class Spot < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :name

  has_many :events
  geocoded_by :address
  validates :name, :address, :latitude, :longitude, presence: true

  before_validation :geocode, if: :address_changed?
  acts_as_gmappable process_geocoding: false

  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
    result = "<h2>#{name}</h2>"
  end
end
