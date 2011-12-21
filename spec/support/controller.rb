module Support
  module ControllerHelpers
    def auth(username=CFG[:basic_auth][:username], password=CFG[:basic_auth][:password])
      @request.env['HTTP_AUTHORIZATION'] = "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
    end
  end
end
