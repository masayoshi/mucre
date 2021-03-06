class OmniauthCallbacksController < ApplicationController
  def twitter
    @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Twitter"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:warning] = I18n.t "devise.omniauth_callbacks.failure", kind: "Twitter", reason: "User create error"
      redirect_to root_path
    end
  rescue
    flash[:error] = I18n.t "devise.omniauth_callbacks.failure", kind: "Twitter", reason: "User create error"
    redirect_to root_path
  end

  def facebook
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Facebook"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t "devise.omniauth_callbacks.failure", kind: "Facebook", reason: "User create error"
      redirect_to root_path
    end
  rescue
    flash[:error] = I18n.t "devise.omniauth_callbacks.failure", kind: "Facebook", reason: "User create error"
    redirect_to root_path
  end
end
