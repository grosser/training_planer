class Participation < ActiveRecord::Base
  belongs_to :person
  belongs_to :webinar
end