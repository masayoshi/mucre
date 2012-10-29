class Event < ActiveRecord::Base
  attr_accessible :address, :description, :end_datetime, :fee, :latitude, :longitude, :place, :start_datetime, :title, :url, :user_id
end
