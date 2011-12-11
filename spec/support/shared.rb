shared_examples_for 'protected' do |method, action|
  it "is protected" do
    send method, action
    response.status.should == 401
  end
end
