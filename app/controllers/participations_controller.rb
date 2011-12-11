class ParticipationsController < ApplicationController
  def create
    @webinar = Webinar.find(params[:webinar_id])
    @person = Person.find_or_create_by_email(params[:email])
    ParticipationMailer.
      confirm_verified_rsvp(@person, @webinar).
      deliver
    redirect_to @webinar, :notice => "An email with a confirmation link was sent to #{params[:email]}, please <b>open your inbox</b> and click it.".html_safe
  end

  def confirm
    if data = UrlStore.decode(params[:id])
      person_id, webinar_id = data.split('-')
      webinar = Webinar.find(webinar_id)
      Participation.create!(
        :person => Person.find(person_id),
        :webinar => webinar
      )
      redirect_to webinar, :notice => :default
    else
      render :text => 'INVALID URL'
    end
  end
end