class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == CFG[:basic_auth][:username] && password == CFG[:basic_auth][:password]
    end
  end
end
