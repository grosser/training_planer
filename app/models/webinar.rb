class Webinar < ActiveRecord::Base
  validates_presence_of :title, :description

  has_many :participations

  def to_param
    "#{id}-#{title.parameterize}"
  end
end