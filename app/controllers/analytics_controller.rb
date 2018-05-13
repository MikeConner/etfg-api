class AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  def by_fund
    
  end
  
  # /analytics/:date/getAnalytics
  def by_date    
    result = []
    Analytic.where(:run_date => Date.parse(params[:date])).find_in_batches do |batch|
      parsed = JSON.parse(AnalyticSerializer.new(batch).serialized_json)['data']
      parsed.each do |a|
        result.push(a['attributes'])
      end      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end
  end
  
  def aggregate
    
  end
  
private
  def check_permissions
    unless current_user.has_permission(:read_analytics)
      head :forbidden
    end
  end
end
