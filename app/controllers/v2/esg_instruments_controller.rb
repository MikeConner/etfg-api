require 'utilities'

class V2::EsgInstrumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions
  
  # /v2/esg_instruments
  def index
    result = []
    EsgInstrument.all.find_in_batches do |batch|
      result += EsgInstrumentSerializer.extract(batch) 
    end
            
    if result.empty?
      head :not_found
    else
      fname = "Instruments #{params[:date]}"
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
