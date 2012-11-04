# -*- encoding: utf-8 -*
module ArtistsHelper
  def additional_tag_artists_path(additional_tag)
    if params[:tags].present?
      tags_param = params[:tags] + "+" + additional_tag
    else
      tags_param = additional_tag
    end
    artists_path(tags: tags_param, sort: params[:sort])
  end

  def remove_tag_artists_path(remove_tag)
    tags_params = params[:tags].split("+")
    tags_params.delete(remove_tag)
    tags = tags_params.join("+") if tags_params.present?
    artists_path(tags: tags, sort: params[:sort])
  end

  def tagged_artists_path(tag)
    artists_path(tags: tag, sort: params[:sort])
  end

  def sort_artists_path(sort)
    artists_path(tags: params[:tags], sort: sort)
  end

  def remove_sort_artists_path
    artists_path(tags: params[:tags])
  end

  def readable_artist_sort_condition(sort)
    case sort
    when "ld"
      "ログイン日時が新しい順"
    else
      "登録日時が新しい順"
    end
  end
end
