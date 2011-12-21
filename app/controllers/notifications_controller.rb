class NotificationsController < ApplicationController
  before_filter :authenticate

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
end
