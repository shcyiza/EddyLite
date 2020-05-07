Rails.application.routes.draw do
  root to: 'artists#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  get 'api/artists/:artist_id/tracks', to: 'api#artist_tracks'
  get 'api/artists/:artist_id/revenues', to: 'api#artist_revenues'
end
