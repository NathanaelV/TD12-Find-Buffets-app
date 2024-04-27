Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :buffets, only: %i[show new create]
end
