Mucre::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  match '/about', to: 'static_pages#about'
  match '/policy', to: 'static_pages#policy'
  match '/help', to: 'static_pages#help'
  root to: 'static_pages#home'
end
