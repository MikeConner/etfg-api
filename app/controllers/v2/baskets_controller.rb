require 'utilities'

class V2::BasketsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v2/baskets?date=20180509&output=[csv|json]
  # /v2/baskets?start_date=20180509&end_date=20180509
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    set_output_type
    result = []
    Basket.where(Utilities.date_clause(params, 'baskets'))
          .where(:output_region => @region).find_in_batches do |batch|
      result += BasketSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Baskets #{params[:date]}" : 
                                         "#{@region} Baskets #{params[:start_date]}_#{params[:end_date]}"
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

  # /v2/baskets/tickers?date=20180509&output=[csv|json]
  # /v2/baskets/tickers?start_date=20180509&end_date=20180509
  def tickers        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    result = Hash.new
    set_output_type
    
    tickers = Basket.where(Utilities.date_clause(params, 'baskets'))
                    .where(:output_region => @region).pluck(:composite_ticker).uniq
    tickers.each do |ticker|
      cnt = Basket.where(Utilities.date_clause(params, 'baskets'))
                  .where(:output_region => @region, :composite_ticker => ticker).count
      result[ticker] = cnt
    end    
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Baskets #{params[:date]}" : 
                                         "#{@region} Baskets #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/baskets/:fund?date=20180509&output=[csv|json]
  # /v2/baskets/:fund?start_date=20180509&end_date=20180509
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
        
    fund = params[:id] || params[:fund]
    set_output_type
    
    result = []
    Basket.where(Utilities.date_clause(params, 'baskets'))
          .where(:composite_ticker => fund, :output_region => @region)
          .find_in_batches do |batch|
      result += BasketSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Baskets #{fund}-#{params[:date]}" : 
                                         "#{@region} Baskets #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
    unless current_user.has_permission(:read_baskets)
      head :forbidden
    end
  end
end
