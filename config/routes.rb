Rails.application.routes.draw do
  resources :sales
  resources :artists
  root to: 'artists#index'
  get '/revenues', to: 'sales#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  get '/artists/:id/tracks', to: 'artists#tracks'
end
