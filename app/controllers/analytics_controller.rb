class AnalyticsController < ApplicationController
  before_action :authenticate_user!
  
  def by_fund
    
  end
  
  def by_date    
    result = []
    Analytic.where(:run_date => Date.parse(params[:date])).find_in_batches do |batch|
      parsed = JSON.parse(AnalyticSerializer.new(batch).serialized_json)['data']
      parsed.each do |a|
        result.push(a['attributes'])
      end      
    end
    
    render :json => result
  end
  
  def aggregate
    
  end
end
