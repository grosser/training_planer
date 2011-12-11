class Person < ActiveRecord::Base
  validates_presence_of :email

  has_many :participations

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_param
    "#{id}-#{full_name}"
  end
end