class V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions, :except => [:create, :destroy]
  before_action :check_manage_users, :only => [:create, :destroy]
  
  def index
    result = []
    User.all.each do |u|
      result.push(get_permissions(u))
    end
    
    render :json => result
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end

  def show
    user = User.find_by_id(params[:id])
    if user.nil?
      head :not_found and return
    end
    
    render :json => get_permissions(user).except(:id)
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
 
  def create    
    unless current_user.has_permission(:manage_users)
      head :forbidden and return
    end

    u = User.create!(:username => params[:username], :password => params[:password])
    
    render :json => {:id => u.id}
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
  
  def update
    user = User.find_by_id(params[:id])
    if user.nil?
      head :not_found and return
    end
    
    perms = []
    params[:permissions].each do |p|
      if Action.descriptions.include?(p)
        perms.push(p)
      else
        raise "Invalid permission: #{p}"
      end
    end
    
    user.actions.delete_all
    perms.each do |p|
      user.actions << Action.find_by_description(p)
    end
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
  
  def destroy
    user = User.find_by_id(params[:id])
    if user.nil?
      head :not_found and return
    end
    
    unless current_user.has_permission(:manage_users)
      head :forbidden and return
    end
    
    user.destroy
    
    head :ok
    
  rescue Exception => ex
    render :json => {:error => ex.message, :trace => ex.backtrace}, :status => :internal_server_error    
  end
  
private
  def get_permissions(u)
    {:id => u.id, :username => u.username, :permissions => u.actions.pluck(:description)}
  end
  
  def check_manage_users
    unless current_user.has_permission(:manage_users)
      head :forbidden
    end    
  end
  
  def check_permissions
    unless current_user.has_permission(:change_permissions)
      head :forbidden
    end
  end
end
