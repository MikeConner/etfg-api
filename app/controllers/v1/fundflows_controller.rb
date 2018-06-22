require 'utilities'

class V1::FundflowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions

  # /v1/fundflows?date=20180509&output=[csv|json]
  # /v1/fundflows?start_date=20180509&end_date=20180509
  # /api/fundflow/:date/getFundFlow
  # /api/fundflow/start_date:end_date/getFundFlow
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    set_output_type
    
    result = []
    FundFlow.where(Utilities.date_clause(params, 'fundflows')).find_in_batches do |batch|
      result += FundFlowSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "FundFlows #{params[:date]}" : "FundFlows #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v1/fundflows/:fund?date=20180509&output=[csv|json]
  # /v1/fundflows/:fund?start_date=20180509&end_date=20180509
  # /api/fundflow/:date/:fund/getFundFlow
  # /api/fundflow/start_date:end_date/:fund/getFundFlow
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    fund = params[:id] || params[:fund]
    set_output_type
    
    result = []
    FundFlow.where(Utilities.date_clause(params, 'fundflows')).where(:composite_ticker => fund).find_in_batches do |batch|
      result += FundFlowSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "FundFlows #{fund}-#{params[:date]}" : "FundFlows #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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

  # /v1/fundflows/products?date=20180509
  # /v1/fundflows/products?start_date=20180509&end_date=20180512
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    render :json => FundFlow.where(Utilities.date_clause(params, 'fundflows')).order(:composite_ticker).map(&:composite_ticker).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
  
private
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