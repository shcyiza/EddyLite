Rails.application.routes.draw do
  resources :sales
  resources :tracks
  resources :albums
  resources :artists
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
