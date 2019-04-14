class V2::EsgPooledInstrumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  def index
    unless params.has_key?(:date)
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
 
    recs = EsgPooledInstrument.date_range(params[:date]).where(:exclude_from_ts => false)
    result = []
   
    result = PooledInstrumentSerializer.extract(recs) 
         
    if result.empty?
      head :not_found
    else
      render :json => result
    end    

  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error         
  end
  
private
  def check_permissions
    unless current_user.has_permission(:cca_internal)
      head :forbidden
    end
  end
end
