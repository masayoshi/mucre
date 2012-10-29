class Event < ActiveRecord::Base
  attr_accessible :address, :description, :end_datetime, :fee, :latitude, :longitude, :place, :start_datetime, :title, :url, :user_id
  attr_accessible :tag_list

  attr_accessor :start_date, :start_time, :end_date, :end_time
  attr_accessible :start_date, :start_time, :end_date, :end_time

  belongs_to :user
  geocoded_by :address
  validates :title, :place, :address, :fee, :description, :latitude, :longitude, :start_datetime, :end_datetime, :user_id,  presence: true
  validates_format_of :start_time, :end_time, with: /\d{1,2}:\d{2}/

  after_initialize :get_datetimes
  before_validation :set_datetimes

  before_validation :geocode, if: :address_changed?
  acts_as_taggable

  def get_datetimes
    self.start_datetime ||= Time.now  # if the start_datetime is not set, set it to now
    self.end_datetime ||= Time.now  # if the end_datetime is not set, set it to now

    self.start_date ||= self.start_datetime.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
    self.end_date ||= self.end_datetime.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
    self.start_time ||= "#{'%02d' % self.start_datetime.hour}:#{'%02d' % self.start_datetime.min}" # extract the time
    self.end_time ||= "#{'%02d' % self.end_datetime.hour}:#{'%02d' % self.end_datetime.min}" # extract the time
  end

  def set_datetimes
    self.start_datetime = "#{self.start_date} #{self.start_time}" # convert the two fields back to db
    self.end_datetime = "#{self.end_date} #{self.end_time}" # convert the two fields back to db
  end
end
