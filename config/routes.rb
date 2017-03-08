Rails.application.routes.draw do
  resource :playlists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#proof_of_concept'
end
