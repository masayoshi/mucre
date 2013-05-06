# == Schema Information
#
# Table name: spots
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Spot < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :name

  has_many :events

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

  validates :name, :address, :latitude, :longitude, presence: true

  acts_as_gmappable process_geocoding: false

  self.per_page = 20

  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
    result = "<h2>#{name}</h2>"
  end
end
