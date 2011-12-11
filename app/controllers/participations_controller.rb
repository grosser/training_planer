class ParticipationsController < ApplicationController
  def create
    @webinar = Webinar.find(params[:webinar_id])
    ParticipationMailer.
      confirm_verified_rsvp(params[:email], @webinar).
      deliver
    redirect_to @webinar, :notice => "An email with a confirmation link was sent to #{params[:email]}, please <b>open your inbox</b> and click it.".html_safe
  end
end