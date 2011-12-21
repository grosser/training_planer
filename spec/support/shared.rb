shared_examples_for 'protected' do |action, options={}|
  it "is protected" do
    get action, options
    response.status.should == 401
  end
end

def all_emails
  ActionMailer::Base.deliveries
end

def last_email_sent
  all_emails.last
end

def reset_mailer
  all_emails.clear
end

def mailbox_for(address)
  all_emails.select { |email|
    (email.to && email.to.include?(address)) ||
      (email.bcc && email.bcc.include?(address)) ||
      (email.cc && email.cc.include?(address)) }
end

def validate_emails_are_sane
  all_emails.each do |mail|
    mail.body.should_not =~ /="\/"/ # have a path
    mail.body.should_not =~ /&gt;|&lt;/ # have escaped < / >
  end
end