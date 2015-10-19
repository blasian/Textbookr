class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Devise::Controllers::Helpers

  def not_found
  	render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def after_sign_up_path_for(resource)
  	current_user_account_path
  end
end
