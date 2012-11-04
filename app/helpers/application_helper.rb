# -*- encoding: utf-8 -*
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

 def additional_tag_events_path(additional_tag)
    if params[:tags].present?
      tags_param = params[:tags] + "+" + additional_tag
    else
      tags_param = additional_tag
    end
    events_path(tags: tags_param, fee: params[:fee], sort: params[:sort], range: params[:range])
  end

  def remove_tag_events_path(remove_tag)
    tags_params = params[:tags].split("+")
    tags_params.delete(remove_tag)
    tags = tags_params.join("+") if tags_params.present?
    events_path(tags: tags, fee: params[:fee], sort: params[:sort], range: params[:range])
  end

  def tagged_events_path(tag)
    events_path(tags: tag, fee: params[:fee], sort: params[:sort], range: params[:range])
  end

  def sort_events_path(sort)
    events_path(tags: params[:tags], fee: params[:fee], sort: sort, range: params[:range])
  end

  def remove_sort_events_path
    events_path(tags: params[:tags], fee: params[:fee], range: params[:range])
  end

  def readable_sort_condition(sort)
    case sort
    when "rd"
      "登録日時が新しい順"
    else
      "開催日時順"
    end
  end

  def fee_filter_events_path(fee)
    events_path(tags: params[:tags], fee: fee, sort: params[:sort], range: params[:range])
  end

  def remove_fee_filter_events_path
    events_path(tags: params[:tags], sort: params[:sort], range: params[:range])
  end

  def readable_fee_filter_condition(fee)
    case fee
    when "free"
      "無料"
    when "pay"
      "有料"
    else
      "すべて"
    end
  end

  def range_scoped_events_path(range)
    events_path(tags: params[:tags], fee: params[:fee], sort: params[:sort], range: range)
  end

  def remove_range_events_path
    events_path(tags: params[:tags], fee: params[:fee], sort: params[:sort])
  end

  def readable_range_condition(range)
    case range
    when "week"
      "１週間以内に開催"
    when "month"
      "１ヶ月以内に開催"
    when "all"
      "開催済みを含むすべて"
    else
      "これから開催"
    end
  end
end
