class V2::EsgPooledInstrumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  def index
    unless params.has_key?(:date)
      render :json => {:error => I18n.t('date_required')}, :status => :bad_request and return
    end
 
    result = []
    # true ensures no duplicates
    EsgPooledInstrument.date_range(params[:date], true).find_in_batches do |batch|
      result += EsgPooledInstrumentSerializer.extract(batch) 
    end
  
    if result.empty?
      head :not_found
    else
      fname = "Pooled Instruments #{params[:date]}"
      send_data Utilities.csv_emitter(result),
                :filename => "#{fname}.csv",
                :type => "text/csv",
                :disposition => 'attachment'
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
