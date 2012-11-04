# -*- coding: utf-8 -*-
class ArtistsController < ApplicationController
  def index
    @artists = User.refine_search(params).paginate(page: params[:page])
    @tags = User.refine_search(params).tag_counts
  end

  def show
    @artist = User.confirmed.find_by_username(params[:username])
    if @artist.present?
      @artist_twitter = @artist.authentications.find_by_provider("twitter")
      @artist_facebook = @artist.authentications.find_by_provider("facebook")
      @events = @artist.events.order('created_at DESC').limit(5)
    else
      redirect_to artists_path, alert: "ご指定のアーティストは見つかりませんでした"
    end
  end
end
