shared_examples_for 'protected' do |action, options={}|
  it "is protected" do
    get action, options
    response.status.should == 401
  end
end

def auth(username=CFG[:basic_auth][:username], password=CFG[:basic_auth][:password])
  @request.env['HTTP_AUTHORIZATION'] = "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
end
