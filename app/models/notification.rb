class Notification < ActiveForm
  attr_accessor :subject, :body, :person_ids
  validates_presence_of :subject, :body, :person_ids

  def people
    return [] if person_ids.blank?
    Person.find(person_ids)
  end
end