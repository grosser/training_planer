class Person < ActiveRecord::Base
  validates_presence_of :email

  has_many :participations

  before_create :set_verified_for_training, :unless => :verified_for_training?

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_param
    "#{id}-#{full_name}"
  end

  private

  def set_verified_for_training
    self.verified_for_training = !!(email =~ /\.(gov|org)$/)
    true
  end
end