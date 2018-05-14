class FundFlowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions

  # /fundflow/:date/:fund/getFundFlow
  def by_fund
    result = []
    FundFlow.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += FundFlowSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end        

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /fundflow/:date/getFundFlow
  def by_date
    result = []
    FundFlow.where(:run_date => resolve_date(params[:date])).find_in_batches do |batch|
      result += FundFlowSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end            

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
private
  def check_permissions
    unless current_user.has_permission(:read_fund_flow)
      head :forbidden
    end
  end
  
  def resolve_date(date_param)
    if "current" == date_param.downcase
      FundFlow.maximum(:run_date)
    else
      Date.parse(date_param)
    end
  end
end
