require 'utilities'

class V2::BasketHoldingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v2/basket_holdings?date=20180509&output=[csv|json]
  # /v2/basket_holdings?start_date=20180509&end_date=20180509
  def index        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    result = []
    BasketHolding.where(Utilities.date_clause(params, 'baskets'))
                 .where(:output_region => @region).find_in_batches do |batch|
      result += BasketHoldingSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found and return
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Basket Holdings #{params[:date]}" : 
                                         "#{@region} Basket Holdings #{params[:start_date]}_#{params[:end_date]}"
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

  # /v2/basket_holdings/tickers?date=20180509&output=[csv|json]
  # /v2/basket_holdings/tickers?start_date=20180509&end_date=20180509
  def tickers        
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
    
    result = Hash.new
    
    tickers = BasketHolding.where(Utilities.date_clause(params, 'basket_holdings'))
                           .where(:output_region => @region).pluck(:composite_ticker).uniq
    tickers.each do |ticker|
      cnt = BasketHolding.where(Utilities.date_clause(params, 'basket_holdings'))
                         .where(:output_region => @region, :composite_ticker => ticker).count
      result[ticker] = cnt
    end    
    
    if result.empty?
      head :not_found
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Basket Holdings #{params[:date]}" : 
                                         "#{@region} Basket Holdings #{params[:start_date]}_#{params[:end_date]}"
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
  
  # /v2/basket_holdings/:fund?date=20180509&output=[csv|json]
  # /v2/basket_holdings/:fund?start_date=20180509&end_date=20180509
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end

    set_region
    unless Action.verify_region(current_user, @region)
      head :forbidden and return
    end
        
    fund = params[:id] || params[:fund]
    
    result = []
    BasketHolding.where(Utilities.date_clause(params, 'basket_holdings'))
                 .where(:composite_ticker => fund, :output_region => @region)
                 .find_in_batches do |batch|
      result += BasketHoldingSerializer.extract(batch)      
    end
    
    if result.empty?
      head :not_found
    else
      set_output_type
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "#{@region} Basket Holdings #{fund}-#{params[:date]}" : 
                                         "#{@region} Basket Holdings #{fund}-#{params[:start_date]}_#{params[:end_date]}"
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
    @region = (params[:region] || 'US').upcase
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
