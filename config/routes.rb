Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :buffets, only: %i[new create]
end
