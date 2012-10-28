Mucre::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"} do
    match "/settings/account", to: "devise/registrations#edit"
  end

  get "/settings/profile"
  get "/settings/services"
  put "/settings/update"

  match '/about', to: 'static_pages#about'
  match '/policy', to: 'static_pages#policy'
  match '/help', to: 'static_pages#help'
  root to: 'static_pages#home'
end
#== Route Map
# Generated on 27 Oct 2012 15:14
#
#             user_session POST   /users/sign_in(.:format)               devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#  user_omniauth_authorize        /users/auth/:provider(.:format)        omniauth_callbacks#passthru {:provider=>/twitter|facebook/}
#   user_omniauth_callback        /users/auth/:action/callback(.:format) omniauth_callbacks#(?-mix:twitter|facebook)
#            user_password POST   /users/password(.:format)              devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                          PUT    /users/password(.:format)              devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
#        user_registration POST   /users(.:format)                       devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
#                          PUT    /users(.:format)                       devise/registrations#update
#                          DELETE /users(.:format)                       devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)          devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)      devise/confirmations#new
#                          GET    /users/confirmation(.:format)          devise/confirmations#show
#                    about        /about(.:format)                       static_pages#about
#                   policy        /policy(.:format)                      static_pages#policy
#                     help        /help(.:format)                        static_pages#help
#                     root        /                                      static_pages#home
