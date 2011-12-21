module Support
  module RequestHelpers
    def auth
      page.driver.browser.basic_authorize  CFG[:basic_auth][:username], CFG[:basic_auth][:password]
    end
  end
end
