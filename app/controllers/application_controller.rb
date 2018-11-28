class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  respond_to :json

  before_action :authenticate_user
  before_action :set_schema

  def authenticate_user
    #if request.headers['Authorization'].present?
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.find_by_username(username)
      if @current_user and @current_user.valid_password?(password)
        sign_in :user, @current_user
      end
    end
  end

  def set_schema
    if request.fullpath.match(/^(\/v2)/)
      Action.table_name = 'apiv2.actions'
      ActionCategory.table_name = 'apiv2.action_categories'
      Analytic.table_name = 'apiv2.analytics'
      Constituent.table_name = 'apiv2.constituents'
      FundFlow.table_name = 'apiv2.fund_flows'
      Industry.table_name = 'apiv2.industries'
      User.table_name = 'apiv2.users'
    elsif request.fullpath.match(/^(\/v1)/)
      Action.table_name = 'api.actions'
      ActionCategory.table_name = 'api.action_categories'
      Analytic.table_name = 'api.analytics'
      Constituent.table_name = 'api.constituents'
      FundFlow.table_name = 'api.fund_flows'
      Industry.table_name = 'api.industries'
      User.table_name = 'api.users'
    end
  end

private
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end
end
