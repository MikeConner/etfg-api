class AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /analytics/:date/:fund/getAnalytics
  def by_fund
    result = []
    Analytic.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += AnalyticSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end    

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /analytics/:date/getAnalytics
  def by_date    
    result = []
    
    Analytic.where(:run_date => resolve_date(params[:date])).find_in_batches do |batch|
      result += AnalyticSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /analytics/:function/:date/:fund/:group/getAggregateFunction
  def aggregate
    #TODO GROUP NOT USED???
    
    # Ensure valid function first
    operator = params[:function].downcase
    # Ensure valid function
    unless ['min', 'max', 'avg'].include?(operator)
      render :json => {:error => 'Invalid function'}, :status => :bad_request and return
    end
        
    # apply aggregate function to data
    foci = Industry.where(:composite_ticker => params[:fund]).map(&:focus).uniq
    if foci.empty?
      render :json => {:error => 'No industry data found'}, :status => :not_found
    else
      # Get all securities in all focus areas related to the fund we're asking about
      tickers = Industry.where('focus in (?)', foci).pluck(:composite_ticker)
      # Pull the Analytics data for all those tickers on the given date
      raw = Analytic.where(:run_date => resolve_date(params[:date])).where('composite_ticker in (?)', tickers)
      
      if raw.empty?
        render :json => {:error => 'No analytics data found'}, :status => :not_found and return
      end
      
      case operator
      when 'min'
        data = {:min_reward_score => raw.minimum(:reward_score), 
                :min_risk_total_score => raw.minimum(:risk_total_score),
                :min_quant_total_score => raw.minimum(:quant_total_score)}
      when 'max'
        data = {:max_reward_score => raw.maximum(:reward_score), 
                :max_risk_total_score => raw.maximum(:risk_total_score),
                :max_quant_total_score => raw.maximum(:quant_total_score)}
      when 'avg'
        data = {:avg_reward_score => raw.average(:reward_score), 
                :avg_risk_total_score => raw.average(:risk_total_score),
                :avg_quant_total_score => raw.average(:quant_total_score)}
      end
      
      render :json => data    
    end   
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
private
  def check_permissions
    unless current_user.has_permission(:read_analytics)
      head :forbidden
    end
  end
  
  def resolve_date(date_param)
    if "current" == date_param.downcase
      Analytic.maximum(:run_date)
    else
      Date.parse(date_param)
    end
  end
end
