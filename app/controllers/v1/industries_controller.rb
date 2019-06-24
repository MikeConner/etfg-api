require 'utilities'

class V1::IndustriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v1/industries?date=20180509&output=[csv/json] (defaults to json)
  # /v1/industries?start_date=20180509&end_date=20180509
  # /api/industry/:date/getIndustry
  # /api/industry/start_date:end_date/getIndustry
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

    set_output_type
      
    result = []
    Industry.where(Utilities.date_clause(params, 'industries', 1)).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "Industry #{params[:date]}" : "Industry #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v1/industries/:fund?date=20180509&data_type=[csv|json]
  # /v1/industries/:fund?start_date=20180509&end_date=20180509
  # /api/industry/:date/:fund/getIndustry
  # /api/industry/start_date:end_date/:fund/getIndustry
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
    
    fund = params[:id] || params[:fund]
    set_output_type
    
    result = []
    Industry.where(Utilities.date_clause(params, 'industries', 1)).where(:composite_ticker => fund).find_in_batches do |batch|
      result += IndustrySerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "Industry #{fund}-#{params[:date]}" : "Industry #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
  
  # /api/industry/csv/:date/:fund/getIndustry
  # /api/industry/csv/:date/getIndustry
  def csv
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    unless current_user.has_permission(:full_historical)   
      earliest_date = Utilities.earliest_date(params, 'industries')
      if earliest_date < Utilities::TESTED_DATA_BOUNDARY
        head :forbidden and return
      end
    end
    
    fund = params[:fund]
    fname = params.has_key?(:date) ? "Industry #{fund} #{params[:date]}" : "Industry #{fund} #{params[:start_date]}_#{params[:end_date]}"
    
    result = []
        
    if fund.nil?
      # Index
      Industry.where(Utilities.date_clause(params, 'industries', 1)).find_in_batches do |batch|
        result += IndustrySerializer.extract(batch)      
      end
    else
      # Show
      fname += "_#{fund}"
      Industry.where(Utilities.date_clause(params, 'industries', 1)).where(:composite_ticker => fund).find_in_batches do |batch|
        result += IndustrySerializer.extract(batch)      
      end
    end
    
    if result.empty?
      head :not_found
    else       
      send_data Utilities.csv_emitter(result),
                :filename => "#{fname}.csv",
                :type => "text/csv",
                :disposition => 'attachment'
    end    
            
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error
  end
  
  # /v1/industries/:fund/exposures?date=20180509&type=geographic&output=[csv|json]
  # /v1/industries/:fund/exposures?start_date=20180509&end_date=20180512&type=geographic
  # /api/industry/exposures/:type/:date/:fund/getIndustryExposures
  # /api/industry/exposures/:type/start_date:end_date/:fund/getIndustryExposures
  def exposures
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
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
    
    fund = params[:id] || params[:fund]
    set_output_type
    fieldname = "#{params[:type].downcase}_exposure"
    
    result = []
    Industry.where(Utilities.date_clause(params, 'industries', 1), :composite_ticker => params[:fund])
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
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "Industry #{fieldname}-#{fund}-#{params[:date]}" : "Industry #{fieldname}-#{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
  # /v1/industries/products?date=20180509&
  # /v1/industries/products?start_date=20180509&end_date=20180512
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
    
    render :json => Industry.where(Utilities.date_clause(params, 'industries', 1)).order(:composite_ticker).map(&:composite_ticker).uniq
    
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
    unless current_user.has_permission(:read_industry)
      head :forbidden
    end
  end  
end
