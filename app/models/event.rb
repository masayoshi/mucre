# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  url                :string(255)
#  fee                :integer          default(0), not null
#  start_datetime     :datetime
#  end_datetime       :datetime
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  spot_id            :integer
#

class Event < ActiveRecord::Base
  attr_accessible :description, :end_datetime, :fee, :start_datetime, :title, :url, :user_id
  attr_accessible :tag_list, :image
  attr_accessible :spot_id, :spot_attributes

  attr_accessor :start_date, :start_time, :end_date, :end_time
  attr_accessible :start_date, :start_time, :end_date, :end_time

  belongs_to :user
  belongs_to :spot
  accepts_nested_attributes_for :spot

  validates :title, :fee, :description,:start_datetime, :end_datetime, :user_id,  presence: true
  validates_format_of :start_time, :end_time, with: /\d{1,2}:\d{2}/

  validates_attachment_size :image, less_than: 3.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']

  after_initialize :get_datetimes
  before_validation :set_datetimes

  acts_as_taggable

  self.per_page = 20

  has_attached_file :image #, styles: { medium: '360x280#'}

  scope :fee_filter, lambda { |condition|
    case condition
    when "free"
      where "fee = ?", 0
    when "pay"
      where "fee > ?", 0
    end
  }

  scope :sort_condition, lambda { |sort|
    case sort
    when "rd"
      order "events.created_at DESC"
    else
      order "start_datetime ASC"
    end
  }

  scope :tags_search, lambda { |tags|
    composed_scope = self.scoped
    if tags.present?
      tags.split("+").each do |tag|
        composed_scope = composed_scope.tagged_with(tag)
      end
    end
    return composed_scope
  }

  scope :date_range, lambda { |range|
    case range
    when "week"
      where "start_datetime > ? and start_datetime < ?", Time.now, Time.now + 1.week
    when "month"
      where "start_datetime > ? and start_datetime < ?", Time.now, Time.now + 1.month
    when "all"
    else
      where "start_datetime > ?", Time.now
    end
  }

  scope :refine_search, lambda { |params|
    date_range(params[:range]).fee_filter(params[:fee]).tags_search(params[:tags]).sort_condition(params[:sort])
  }

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

  def spot_attributes=(spot_attributes)
    self.spot = Spot.where(address: spot_attributes[:address]).first_or_create(name: spot_attributes[:name])
  end
end
