class NotificationsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create]

  def new
    @notification = Notification.new(params[:notification])
  end

  def create
    @notification = Notification.new(params[:notification])
    if @notification.valid?
      @notification.people.each do |person|
        NotificationMailer.notification(@notification, person).deliver
      end
      redirect_to (params[:redirect_to].presence || '/'), :notice => :default
    else
      flash[:alert] = :default
      render 'new'
    end
  end

  def unsubscribe
    person = Person.find_by_email(params[:email])
    person.update_attributes!(:receive_emails => false)
    redirect_to '/', :notice => "You will no longer receive any emails to #{params[:email]} from us!"
  end
end
