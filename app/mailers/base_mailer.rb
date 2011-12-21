class BaseMailer < ActionMailer::Base
  layout 'email'
  default :from => "from@example.com"
  helper :application # :all does not work
end