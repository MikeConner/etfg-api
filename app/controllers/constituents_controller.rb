class ConstituentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # Top constituents
  TOP_N = 10
  
  # /constituent/cusip/:date/:fund/:id/getByCusip
  def by_cusip_id
    result = ConstituentSerializer.extract(Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund], :cusip => params[:id]))
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end        
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /constituent/cusip/:date/:fund/getByCusip
  def by_cusip
    result = []
    Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += ConstituentSerializer.extract(batch)      
    end
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end   
             
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end

  # /constituent/isin/:date/:fund/:id/getByIsin
  def by_isin_id
    result = ConstituentSerializer.extract(Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund], :isin => params[:id]))
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end        
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /constituent/isin/:date/:fund/getByIsin
  def by_isin
    result = []
    Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += ConstituentSerializer.extract(batch)      
    end
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end   
             
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end

  # /constituent/figi/:date/:fund/:id/getByFigi
  def by_figi_id
    result = ConstituentSerializer.extract(Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund], :figi => params[:id]))
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end        
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /constituent/figi/:date/:fund/getByFigi
  def by_figi
    result = []
    Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += ConstituentSerializer.extract(batch)      
    end
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end   
             
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end

  # /constituent/sedol/:date/:fund/:id/getBySedol
  def by_sedol_id
    result = ConstituentSerializer.extract(Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund], :sedol => params[:id]))
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end        
    
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /constituent/sedol/:date/:fund/getBySedol
  def by_sedol
    result = []
    Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).find_in_batches do |batch|
      result += ConstituentSerializer.extract(batch)      
    end
       
    if result.empty?
      head :not_found
    else
      render :json => result
    end   
             
  rescue Exception => ex
    render :json => {:error => ex.message}, :status => :bad_request
  end
  
  # /topconstituents/weight/:date/:fund/getTopConstituents
  def top
    result = ConstituentSerializer.extract(Constituent.where(:run_date => resolve_date(params[:date]), :composite_ticker => params[:fund]).order('weight DESC').limit(TOP_N))
       
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
    unless current_user.has_permission(:read_constituents)
      head :forbidden
    end
  end
  
  def resolve_date(date_param)
    if "current" == date_param.downcase
      Constituent.maximum(:run_date)
    else
      Date.parse(date_param)
    end
  end
end
