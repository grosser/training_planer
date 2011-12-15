class ParticipationsController < ApplicationController
  def create
    @training = Training.find(params[:training_id])
    if @person = Person.find_by_email(params[:email])
      @person.update_attributes(:reason_to_participate => params[:reason_to_participate])
    else
      @person = Person.create(:email => params[:email], :reason_to_participate => params[:reason_to_participate])
    end

    if @person.verified_for_training?
      ParticipationMailer.
        confirm_verified_rsvp(@person, @training).
        deliver
      redirect_to @training, :notice => "An email with a confirmation link was sent to #{params[:email]}, please <b>open your inbox</b> and click it.".html_safe
    else
      ParticipationMailer.
        admin_confirm_unverified_rsvp(@person, @training).
        deliver
      redirect_to @training, :notice => "Your request was sent! Please wait until an admin confirms it."
    end
  end

  def confirm
    if data = UrlStore.decode(params[:id])
      person_id, training_id = data.split('-')
      training = Training.find(training_id)
      person = Person.find(person_id)
      Participation.create!(
        :person => person,
        :training => training
      )

      if params[:confirmed_by_admin]
        person.update_attributes!(:verified_for_training => true)
        ParticipationMailer.
          admin_confirmed_your_rsvp(person, training).
          deliver
      end

      redirect_to training, :notice => :default
    else
      render :text => 'INVALID URL'
    end
  end
end