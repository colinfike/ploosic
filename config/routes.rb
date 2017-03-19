Rails.application.routes.draw do
  resources :playlists, :tracks
  root 'playlists#index'

end
