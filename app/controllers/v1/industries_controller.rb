require 'csv'
require 'utilities'

class V1::IndustriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v1/industries?date=20180509
  # /v1/industries?start_date=20180509&end_date=20180509
  # /api/industry/:date/getIndustry
  # /api/industry/start_date:end_date/getIndustry
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
      
    result = []
    Industry.where(Utilities.date_clause(params, 'industries')).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :bad_request    
  end
  
  # /v1/industries/:fund?date=20180509
  # /v1/industries/:fund?start_date=20180509&end_date=20180509
  # /api/industry/:date/:fund/getIndustry
  # /api/industry/start_date:end_date/:fund/getIndustry
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    fund = params[:id] || params[:fund]
    
    result = []
    Industry.where(Utilities.date_clause(params, 'industries')).where(:composite_ticker => fund).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      render :json => result
    end    

  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :bad_request
  end
  
  # All these work with start/end dates as well
  #
  # /v1/industries/:fund/csv?date=20180509
  # /v1/industries/csv?date=20180509
  # /api/industry/csv/:date/:fund/getIndustry
  # /api/industry/csv/:date/getIndustry
  def csv
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    fund = params[:id] || params[:fund]
    fname = params.has_key?(:date) ? "Industry #{params[:date]}" : "Industry #{params[:start_date]}_#{params[:end_date]}"
    
    result = []
        
    if fund.nil?
      # Index
      Industry.where(Utilities.date_clause(params, 'industries')).find_in_batches do |batch|
        result += IndustrySerializer.extract(batch)      
      end
    else
      # Show
      fname += "_#{fund}"
      Industry.where(Utilities.date_clause(params, 'industries')).where(:composite_ticker => fund).find_in_batches do |batch|
        result += IndustrySerializer.extract(batch)      
      end
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
                :filename => "#{fname}.csv",
                :type => "text/csv",
                :disposition => 'attachment'
    end    
            
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :bad_request
  end
  
  # /v1/industries/:fund/exposures?date=20180509&type=geographic
  # /v1/industries/:fund/exposures?start_date=20180509&end_date=20180512&type=geographic
  # /api/industry/exposures/:type/:date/:fund/getIndustryExposures
  # /api/industry/exposures/:type/start_date:end_date/:fund/getIndustryExposures
  def exposures
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    unless params.has_key?(:type) and 
           ['geographic', 'currency', 'sector', 'industry_group', 'industry', 'subindustry', 'coupon', 'maturity'].include?(params[:type].downcase)
      render :json => {:error => 'Invalid exposure type'}, :status => :bad_request and return
    end
    
    fund = params[:id] || params[:fund]
    fieldname = "#{params[:type].downcase}_exposure"
    
    result = []
    Industry.where(Utilities.date_clause(params, 'industries'), :composite_ticker => params[:fund])
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
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :bad_request
  end
  
  # /v1/industries/products?date=20180509
  # /v1/industries/products?start_date=20180509&end_date=20180512
  def products
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    
    render :json => Industry.where(Utilities.date_clause(params, 'industries')).order(:composite_ticker).map(&:composite_ticker).uniq
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :bad_request    
  end
    
private
  def check_permissions
    unless current_user.has_permission(:read_industry)
      head :forbidden
    end
  end  
end
