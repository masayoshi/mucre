class Event < ActiveRecord::Base
  attr_accessible :address, :description, :end_datetime, :fee, :latitude, :longitude, :place, :start_datetime, :title, :url, :user_id
  attr_accessible :tag_list
  belongs_to :user
  geocoded_by :address
  validates :title, :place, :address, :fee, :description, :latitude, :longitude, :start_datetime, :end_datetime, :user_id,  presence: true
  before_validation :geocode, if: :address_changed?
  acts_as_taggable
end
