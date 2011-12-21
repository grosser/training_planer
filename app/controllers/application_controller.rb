class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if username == CFG[:basic_auth][:username] && password == CFG[:basic_auth][:password]
        session[:is_admin] = true
        true
      end
    end
  end

  def is_admin?
    !!session[:is_admin]
  end
  helper_method :is_admin?
end
