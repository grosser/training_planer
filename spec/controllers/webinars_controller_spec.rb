require 'spec_helper'

describe WebinarsController do
  def auth(username=CFG[:basic_auth][:username], password=CFG[:basic_auth][:password])
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
  end

  describe "#index" do
    it "renders" do
      get :index
      response.should render_template :index
    end

    it "lists webinars" do
      webinar = Factory(:webinar)
      get :index
      assigns(:webinars).should == [webinar]
    end
  end

  describe "#new" do
    it "is protected" do
      get :new
      response.status.should == 401
    end

    it "renders" do
      auth
      get :new
      response.should render_template :new
    end
  end
end