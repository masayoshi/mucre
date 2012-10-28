# -*- coding: utf-8 -*-
class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @user = current_user
    @authentication_twitter = current_user.authentications.find_by_provider("twitter")
    @authentication_facebook = current_user.authentications.find_by_provider("facebook")
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to settings_profile_path, notice: 'プロフィール情報変更が成功しました。'
    else
      render settings_profile_path
    end
  end

  def services
    @authentication_twitter = current_user.authentications.find_by_provider("twitter")
    @authentication_facebook = current_user.authentications.find_by_provider("facebook")
  end
end
