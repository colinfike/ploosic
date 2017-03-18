Rails.application.routes.draw do
  resources :playlists
  root 'playlists#index'

end
