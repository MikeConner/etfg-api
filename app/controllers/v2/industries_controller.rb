require 'utilities'

class V2::IndustriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v2/industries?date=20180509&output=[csv/json] (defaults to json)
  # /v2/industries?start_date=20180509&end_date=20180509
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'industries')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
      
    result = []
    IndustryV2.where(Utilities.date_clause(params, 'industries'))
              .where(:output_region => @region).find_in_batches do |batch|
      result += IndustryV2Serializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Industry #{params[:date]}" : 
                                         "#{@region} Industry #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/industries/:fund?date=20180509&data_type=[csv|json]
  # /v2/industries/:fund?start_date=20180509&end_date=20180509
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'industries')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    fund = params[:id] || params[:fund]
    result = []
    IndustryV2.where(Utilities.date_clause(params, 'industries'))
              .where(:composite_ticker => fund)
              .where(:output_region => @region).find_in_batches do |batch|
      result += IndustryV2Serializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Industry #{fund}-#{params[:date]}" : 
                                         "#{@region} Industry #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/industries/:fund/exposures?date=20180509&type=geographic&output=[csv|json]
  # Don't allow date ranges; take directly from ts_industries
  def exposures
    unless params.has_key?(:date)
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    unless params.has_key?(:type) and Industry::VALID_EXPOSURES.include?(params[:type].downcase)
      render :json => {:error => 'Invalid exposure type'}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'industries')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    fieldname = "#{params[:type].downcase}_exposure"
    
    fund = params[:id] || params[:fund]
    result = []
    sql = "SELECT #{params[:type].downcase}_exposure FROM public.ts_industries WHERE composite_ticker='#{fund}' AND " +
          "etfg_date='#{params[:date]}' AND output_region='#{@region}' " + 
          "AND (inception_date IS NULL OR inception_date <= etfg_date)"
          
    recs = ActiveRecord::Base.connection.execute(sql)
    unless recs.nil?
      recs.each do |rec|
        rec[fieldname].split(/;/).sort.each do |country|
          fields = country.split(/=/)
          raise "Invalid exposure #{country}" unless 2 == fields.count
        
          result.push({:name => fields[0], :weight => fields[1]})
        end
      end
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type
      if 'csv' == @output_type
        fname = "#{@region} Industry #{fieldname}-#{fund}-#{params[:date]}"
        
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
  
  # This doesn't support output type because it's just a simple list
  # /v2/industries/products?date=20180509&
  # /v2/industries/products?start_date=20180509&end_date=20180512
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'industries')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
   
    render :json => IndustryV2.where(Utilities.date_clause(params, 'industries'))
                              .where(:output_region => @region).order(:composite_ticker).map(&:composite_ticker).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
    
private
  def set_region
    @region = (params[:region] || 'US').upcase
  end

  # can be csv or json (default)
  def set_output_type
    # downcase will throw if nil; default to json if missing
    @output_type = params[:output].downcase rescue 'json'
  end
  
  def check_permissions
    unless current_user.has_permission(:read_industry)
      head :forbidden
    end
  end  
end
