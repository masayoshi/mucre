module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  # Returns the full title on a per-page basis.
  def full_title page_title
    base_title = "MuseumCreated.com"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def twitter_account_url uid
    "https://twitter.com/account/redirect_by_id?id=" + uid
  end

  def facebook_account_url uid
    "http://www.facebook.com/" + uid
  end
end
