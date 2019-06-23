require 'utilities'

class V2::ConstituentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # Top constituents
  TOP_N = 10
  
  # It's a show because it always selects a fund
  #   If type and identifier, limit to that; otherwise just return everything for that security and date (range)
  # /v2/constituents/:fund?date=20180509&output=[csv|json]
  # /v2/constituents/:fund?start_date=20180509&end_date=20180520&identifier=US912796PG82&type=isin
   def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
  
    if params.has_key?(:type)
      unless ['cusip', 'isin', 'figi', 'sedol'].include?(params[:type].downcase)
        render :json => {:error => 'Invalid constituent type'}, :status => :bad_request and return
      end
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'constituents')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_region    
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
             
    fund = params[:id] || params[:fund]
    set_output_type
    result = []
    
    if params.has_key?(:identifier)
      result += ConstituentV2Serializer.extract(ConstituentV2.where(Utilities.date_clause(params, 'constituents'))
                                                             .where(:composite_ticker => fund)
                                                             .where(:region => @region)
                                                             .where("#{params[:type].downcase} = '#{params[:identifier]}'"))      
    else
      ConstituentV2.where(Utilities.date_clause(params, 'constituents')).where(:composite_ticker => fund).find_in_batches do |batch|
        result += ConstituentV2Serializer.extract(batch)      
      end
    end
    
    if result.empty?
      head :not_found and return
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Constituents #{fund}-#{params[:date]}" : 
                                         "#{@region} Constituents #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/constituents/products?date=20180509
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'constituents')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    render :json => ConstituentV2.where(Utilities.date_clause(params, 'constituents'))
                                 .where(:region => @region).order(:composite_ticker).map(&:composite_ticker).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
  
  # /v2/constituents/:fund/contents?date=20180509
  def contents
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'constituents')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    fund = params[:id] || params[:fund]
    
    render :json => ConstituentV2.where(Utilities.date_clause(params, 'constituents'))
                                 .where(:composite_ticker => fund)
                                 .where(:region => @region).order(:constituent_name).map(&:constituent_name).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
  
  # /v2/constituents/:fund/top?date=20180509
  def top
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'constituents')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
      
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    fund = params[:id] || params[:fund]
    set_output_type

    # If there is only 1 date, run it normally
    # If there are two - run it multiple times, and return a hash of date -> results
    if params.has_key?(:date)
      result = ConstituentV2Serializer.extract(ConstituentV2.where(Utilities.date_clause(params, 'constituents'))
                                      .where(:composite_ticker => fund ).order('weight DESC').limit(TOP_N))
    else
      result = Hash.new
      for day in Utilities.date_range(params, 'constituents')
        today = ConstituentV2Serializer.extract(ConstituentV2.where(:run_date => day)
                                       .where(:composite_ticker => fund).order('weight DESC').limit(TOP_N))
        result[day] = today unless today.empty?
      end
    end
    
    if result.empty?
      head :not_found and return
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Top Constituents #{fund}-#{params[:date]}" : 
                                         "#{@region} Top Constituents #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
    
private
  def set_region
    @region = params[:region] || 'US'
  end

  # can be csv or json (default)
  def set_output_type
    # downcase will throw if nil; default to json if missing
    @output_type = params[:output].downcase rescue 'json'
  end
  
  def check_permissions
    unless current_user.has_permission(:read_constituents)
      head :forbidden
    end
  end
end
