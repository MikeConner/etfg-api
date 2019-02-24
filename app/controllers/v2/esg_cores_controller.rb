require 'utilities'

class V2::EsgCoresController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  def show
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
        
    isin = params[:id]
    set_output_type

    result = EsgCoreSerializer.extract(EsgCore.where(Utilities.date_clause(params, 'esg_cores', 'etfg_date'))
                                              .where(:isin => isin))      
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        fname = params.has_key?(:date) ? "ESG Core #{isin}-#{params[:date]}" : 
                                         "ESG Core #{isin}-#{params[:start_date]}_#{params[:end_date]}"
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

  def index
    unless params.has_key?(:date) or (params.has_key?(:start_date) and params.has_key?(:end_date))
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
 
    recs = EsgCore.where(Utilities.date_clause(params, 'esg_cores', 'etfg_date'))
    filter = []
    if params.has_key?(:region)
      recs = recs.where(:region => params[:region])
      filter.push('region')
    end
      
    if params.has_key?(:sector)
      recs = recs.where(:sector => params[:sector])
      filter.push('sector')
    end
    
    if params.has_key?(:industry)
      recs = recs.where(:industry => params[:industry])
      filter.push('industry')
    end

    set_output_type
    result = []
   
    result = EsgCoreSerializer.extract(recs) 
         
    if result.empty?
      head :not_found
    else
      if 'csv' == @output_type
        filters = filter.to_s.gsub(/ /, '-').gsub(/(\[|\]|"|,)/, '')
        fname = params.has_key?(:date) ? "ESG Core #{filters}-#{params[:date]}" : 
                                         "ESG Core #{filters}-#{params[:start_date]}_#{params[:end_date]}"
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
  def set_output_type
    # downcase will throw if nil; default to json if missing
    @output_type = params[:output].downcase rescue 'json'
  end

  def check_permissions
    unless current_user.has_permission(:read_esg_core)
      head :forbidden
    end
  end
end
