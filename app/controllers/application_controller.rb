class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private
  def authenticate_admin
  	return if current_user.admin?
  	redirect_to root_path, notice: 'Only Admin can access this page'
  end
end
