require 'utilities'

class V1::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions

  # /v1/analytics?date=20180509&output=[csv|json]
  # /v1/analytics?start_date=20180509&end_date=20180520
  # /api/analytics/:date/getAnalytics
  # /api/analytics/start_date:end_date/getAnalytics
  def index
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'analytics')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_output_type
           
    result = []
    Analytic.where(Utilities.date_clause(params, 'analytics')).find_in_batches do |batch|
      result += AnalyticSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "Analytics #{params[:date]}" : "Analytics #{params[:start_date]}_#{params[:end_date]}"
        send_data Utilities.csv_emitter(result),
                  :filename => "#{fname}.csv",
                  :type => "text/csv",
                  :disposition => 'attachment'
      else
        render :json => result
      end
    end    

  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
  
  # /v1/analytics/:fund?date=20180509&output=[csv|json]
  # /v1/analytics/:fund?start_date=20180509&end_date=20180512
  # /api/analytics/:date/:fund/getAnalytics
  # /api/analytics/start_date:end_date/:fund/getAnalytics
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'analytics')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    fund = params[:id] || params[:fund]
    set_output_type
           
    result = []
    Analytic.where(Utilities.date_clause(params, 'analytics')).where(:composite_ticker => fund).find_in_batches do |batch|
      result += AnalyticSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "Analytics #{fund}-#{params[:date]}" : "Analytics #{fund}-#{params[:start_date]}_#{params[:end_date]}"
        send_data Utilities.csv_emitter(result),
                  :filename => "#{fname}.csv",
                  :type => "text/csv",
                  :disposition => 'attachment'
      else
        render :json => result
      end
    end    

  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
    
  # /v1/analytics/:fund/aggregate?date=20180509&group=asset_class&function=max
  # /v1/analytics/:fund/aggregate?start_date=20180509&end_date=20180512&group=asset_class&function=max
  # /api/analytics/:date/:fund/:group/:function/getAggregateFunction
  # /api/analytics/start_date:end_date/:fund/:group/:function/getAggregateFunction
  def aggregate
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    unless params.has_key?(:fund) or params.has_key?(:id)
      render :json => {:error => 'Ticker required'}, :status => :bad_request and return
    end
    unless params.has_key?(:group) and (false == params[:group].blank?)
      render :json => {:error => I18n.t('valid_group', :groups => Analytic::VALID_GROUPS.join(','))}, :status => :bad_request and return
    end
    unless params.has_key?(:function) and Analytic::VALID_FUNCTIONS.include?(params[:function].downcase)
      render :json => {:error => I18n.t('valid_function', :functions => Analytic::VALID_FUNCTIONS.join(','))}, :status => :bad_request and return
    end
        
    # Extract and validate groups
    groups = []
    params[:group].downcase.split(/:/).each do |g|
      sp = spacey_param(g)
      
      if Analytic::VALID_GROUPS.include?(sp)
        groups.push(sp)
      else        
        render :json => {:error => I18n.t('valid_group', :groups => Analytic::VALID_GROUPS.join(','))}, :status => :bad_request and return
      end
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'analytics')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    # Compute total list of numeric fields (all but the following list)
    field_list = Analytic.new.attributes
    ['id', 'run_date', 'composite_ticker', 'quant_grade', 'created_at', 'updated_at'].each do |f|
      field_list.delete(f)
    end
    select_clause = ""
    field_list.keys.each do |f|
      select_clause += "," unless select_clause.blank?
      
      select_clause += "#{params[:function]}(#{f}) AS #{f}"
    end
    # Build where
    fund = params[:id] || params[:fund]
    where_clause = ""
    groups.each do |group|
      where_clause += "OR " unless where_clause.blank?
      
      where_clause += "#{group} IN (SELECT #{group} FROM industries WHERE composite_ticker='#{fund}') "      
    end

    sql = "SELECT " + select_clause + " FROM analytics WHERE #{Utilities.date_clause(params, 'analytics')} AND composite_ticker in " +
          "(SELECT composite_ticker FROM industries WHERE (#{where_clause}))"
    
    render :json => ActiveRecord::Base.connection.execute(sql)
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
  
  # /v1/analytics/products?date=20180509
  # /v1/analytics/products?start_date=20180509&end_date=20180512
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'analytics')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    render :json => Analytic.where(Utilities.date_clause(params, 'analytics')).order(:composite_ticker).map(&:composite_ticker).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
  
private  
  # can be csv or json (default)
  def set_output_type
    # downcase will throw if nil; default to json if missing
    @output_type = params[:output].downcase rescue 'json'
  end

  # Params like "asset class" might have a space or underscore; normalize to underscore
  # Also ignore capitalization and remove leading/trailing whitespace
  def spacey_param(p)
    p.strip.downcase.gsub(/ /, '_')
  end
  
  def check_permissions
    unless current_user.has_permission(:read_analytics)
      head :forbidden
    end
  end  
end
