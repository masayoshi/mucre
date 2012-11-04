# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  name                   :string(255)
#  biography              :text
#  url                    :string(255)
#  image_url              :string(255)
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :image_url, :name, :url, :biography

  validates :username, presence: true, length: { within: 3..50 }, uniqueness: true, format: { with: /\A[_a-zA-Z0-9]+\Z/ } # only A..Za..z0..9-_
  validates :name, length: { within: 3..100 }, allow_blank: true
  validates :biography, length: { maximum: 2000 }
  validates :url, format: {with: URI::regexp(%w(http https))}, allow_blank: true
  validates_confirmation_of :password

  before_save :fill_image_url

  acts_as_taggable
  attr_accessible :tag_list

  has_many :authentications, dependent: :destroy
  has_many :events, dependent: :destroy

  scope :confirmed, where("confirmed_at IS NOT NULL")

  scope :sort_condition, lambda { |sort|
    case sort
    when "ld"
      order "current_sign_in_at DESC"
    else
      order "confirmed_at DESC"
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

  scope :refine_search, lambda { |params|
    confirmed.tags_search(params[:tags]).sort_condition(params[:sort])
  }

  def self.find_for_twitter_oauth(auth, current_user = nil)
    authentication = Authentication.find_by_provider_and_uid("twitter", auth.uid.to_s)
    dummy_email = "dummy-#{auth['uid']}@mucre.com" # twitter return no email, so set dummy email address because of email wanne be unique.
    logger.info auth.to_yaml

    if authentication.present?
      user = authentication.user
    else
      if current_user.present?
        user = current_user
      else
        user = User.new({
          password: Devise.friendly_token[0,20],
          username: auth.info.nickname,
          email: dummy_email,
          image_url: auth.info.image,
        })
        user.skip_confirmation!
        user.save
      end
      user.authentications.create!({
        provider: "twitter",
        uid: auth.uid.to_s,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        image_url: auth.info.image
      })
    end
    return user
  end

  def self.find_for_facebook_oauth(auth, current_user = nil)
    authentication = Authentication.find_by_provider_and_uid("facebook", auth.uid.to_s)
    logger.info auth.to_yaml

    if authentication.present?
      user = authentication.user
    else
      if current_user.present?
        user = current_user
      elsif User.exists?(email: auth.info.email)
        user = User.find_by_email(auth.info.email)
      else
        user = User.new({
          password: Devise.friendly_token[0,20],
          username: auth.info.nickname,
          email: auth.info.email,
          image_url: auth.info.image,
        })
        user.skip_confirmation!
        user.save
      end
      user.authentications.create!({
        provider: "facebook",
        uid: auth.uid.to_s,
        token: auth.credentials.token,
        image_url: auth.info.image
      })
    end
    return user
  end

  # Skip password require validation if user have authentications
  def password_required?
    super && authentications.blank?
  end

  # Allow user to change password without current password if user have authentications
  def update_with_password(params, *options)
    if authentications.present?
      update_attributes(params, *options)
    else
      super
    end
  end

  private

  def fill_image_url
    self.image_url ||= GravatarImageTag::gravatar_url(self.email).gsub("&amp;","&")
  end
end
