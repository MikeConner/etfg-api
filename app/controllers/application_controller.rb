class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  respond_to :json

  before_action :authenticate_user
   
  def authenticate_user
    #if request.headers['Authorization'].present?
    authenticate_or_request_with_http_basic do |username, password|         
      @current_user = User.find_by_username(username)
      if @current_user and @current_user.valid_password?(password)
        sign_in :user, @current_user
      end
    end
  end

private
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end
end
