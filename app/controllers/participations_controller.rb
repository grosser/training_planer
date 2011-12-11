class ParticipationsController < ApplicationController
  def create
    @webinar = Webinar.find(params[:webinar_id])
    if @person = Person.find_by_email(params[:email])
      @person.update_attributes(:reason_to_participate => params[:reason_to_participate])
    else
      @person = Person.create(:email => params[:email], :reason_to_participate => params[:reason_to_participate])
    end

    if @person.verified_for_webinar?
      ParticipationMailer.
        confirm_verified_rsvp(@person, @webinar).
        deliver
      redirect_to @webinar, :notice => "An email with a confirmation link was sent to #{params[:email]}, please <b>open your inbox</b> and click it.".html_safe
    else
      ParticipationMailer.
        admin_confirm_unverified_rsvp(@person, @webinar).
        deliver
      redirect_to @webinar, :notice => "Please wait until an admin confirms your request."
    end
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