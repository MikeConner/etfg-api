require 'csv'

class V1::IndustriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  def index        
    unless params.has_key?[:date]
      render :json => {:error => 'Date required'}, :status => :bad_request and return
    end
      
    result = []
    Industry.where(:run_date => resolve_date(params[:date])).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request    
  end
  
  def show
    
  end
  
  def exposures
    
  end
  
  # /industry/:date/:fund/getIndustry
  def by_fund
    result = []
    Industry.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end        

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end

  # /industry/csv/:date/:fund/getIndustry
  def csv_by_fund
    result = []
    run_date = resolve_date(params[:date])
    Industry.where(:run_date => run_date, :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      csv_string = CSV.generate do |csv|
        csv << result[0].keys
        
        result.each do |row|
          csv << row.values
        end
      end
      
      send_data csv_string,
                :filename => "Industry #{run_date.to_s}_#{params[:fund]}.csv",
                :type => "text/plain",
                :disposition => 'attachment'
    end         

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
    
  # /industry/:date/getIndustry
  def by_date
    result = []
    
    Industry.where(:run_date => resolve_date(params[:date])).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request    
  end
 
  # /industry/csv/:date/getIndustry
  def csv_by_date
    result = []
    run_date = resolve_date(params[:date])
    Industry.where(:run_date => run_date).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)
    end
    
    if result.empty?
      head :not_found
    else
      csv_string = CSV.generate do |csv|
        csv << result[0].keys
        
        result.each do |row|
          csv << row.values
        end
      end
      
      send_data csv_string,
                :filename => "Industry #{run_date.to_s}.csv",
                :type => "text/plain",
                :disposition => 'attachment'
    end         

  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /industry/exposures/:type/:date/:fund/getIndustryExposures
  def legacy_exposures
    # validate exposure type
    unless ['geographic', 'currency', 'sector', 'industry_group', 'industry', 'subindustry', 'coupon', 'maturity'].include?(params[:type].downcase)
      render :json => {:error => 'Invalid exposure type'}, :status => :bad_request and return
    end
    
    fieldname = "#{params[:type].downcase}_exposure"
    
    result = []
    Industry.where(:run_date => resolve_date(params[:date]), 
                   :composite_ticker => params[:fund])
            .where("#{fieldname} IS NOT NULL")
            .pluck(fieldname.to_sym).each do |value|
              value.split(/;/).sort.each do |country|
                fields = country.split(/=/)
                raise "Invalid exposure #{country}" unless 2 == fields.count
                result.push({:name => fields[0], :weight => fields[1]})
              end
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
    unless current_user.has_permission(:read_industry)
      head :forbidden
    end
  end
  
  def resolve_date(date_param)
    if "current" == date_param.downcase
      Industry.maximum(:run_date)
    else
      Date.parse(date_param)
    end
  end
end
