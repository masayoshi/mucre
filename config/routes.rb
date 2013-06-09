Mucre::Application.routes.draw do

  resources :contact_forms, only: [:new, :create]
  resources :spots
  resources :events

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"} do
    match "/settings/account", to: "devise/registrations#edit"
  end

  match "/artists", to: "artists#index", as: "artists", via: :get
  match "/artists/:username", to: "artists#show", as: "artist", via: :get

  get "/settings/profile"
  get "/settings/services"
  put "/settings/update"

  match '/about', to: 'static_pages#about', via: :get
  match '/policy', to: 'static_pages#policy', via: :get
  match '/contact', to: 'contact_forms#new', via: :get
  root to: 'static_pages#home'
end
#== Route Map
# Generated on 09 Jun 2013 13:32
#
#         new_contact_form GET    /contact_forms/new(.:format)           contact_forms#new
#                    spots GET    /spots(.:format)                       spots#index
#                          POST   /spots(.:format)                       spots#create
#                 new_spot GET    /spots/new(.:format)                   spots#new
#                edit_spot GET    /spots/:id/edit(.:format)              spots#edit
#                     spot GET    /spots/:id(.:format)                   spots#show
#                          PUT    /spots/:id(.:format)                   spots#update
#                          DELETE /spots/:id(.:format)                   spots#destroy
#                   events GET    /events(.:format)                      events#index
#                          POST   /events(.:format)                      events#create
#                new_event GET    /events/new(.:format)                  events#new
#               edit_event GET    /events/:id/edit(.:format)             events#edit
#                    event GET    /events/:id(.:format)                  events#show
#                          PUT    /events/:id(.:format)                  events#update
#                          DELETE /events/:id(.:format)                  events#destroy
#         settings_account        /settings/account(.:format)            devise/registrations#edit
#         new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
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
#                  artists GET    /artists(.:format)                     artists#index
#                   artist GET    /artists/:username(.:format)           artists#show
#         settings_profile GET    /settings/profile(.:format)            settings#profile
#        settings_services GET    /settings/services(.:format)           settings#services
#          settings_update PUT    /settings/update(.:format)             settings#update
#                    about GET    /about(.:format)                       static_pages#about
#                   policy GET    /policy(.:format)                      static_pages#policy
#                  contact GET    /contact(.:format)                     contact_forms#new
#                     root        /                                      static_pages#home
