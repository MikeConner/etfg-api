require 'utilities'

class V2::FundflowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions

  # /v2/fundflows?date=20180509&output=[csv|json]
  # /v2/fundflows?start_date=20180509&end_date=20180509
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'fundflows')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end

    result = []
    
    FundFlowV2.where(Utilities.date_clause(params, 'fundflows'))
              .where(:region => @region).find_in_batches do |batch|
      result += FundFlowV2Serializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type    
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} FundFlows #{params[:date]}" : 
                                         "#{@region} FundFlows #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/fundflows/:fund?date=20180509&output=[csv|json]
  # /v2/fundflows/:fund?start_date=20180509&end_date=20180509
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'fundflows')
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
    FundFlowV2.where(Utilities.date_clause(params, 'fundflows'))
              .where(:composite_ticker => fund, :region => @region)
              .find_in_batches do |batch|
      result += FundFlowV2Serializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} FundFlows #{fund}-#{params[:date]}" : 
                                         "#{@region} FundFlows #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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

  # /v2/fundflows/products?date=20180509
  # /v2/fundflows/products?start_date=20180509&end_date=20180512
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'fundflows')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    render :json => FundFlowV2.where(Utilities.date_clause(params, 'fundflows'))
                              .where(:region => @region)
                              .order(:composite_ticker).map(&:composite_ticker).uniq
    
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
    unless current_user.has_permission(:read_fund_flow)
      head :forbidden
    end
  end
end
