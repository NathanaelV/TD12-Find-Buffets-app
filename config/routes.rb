Rails.application.routes.draw do
  devise_for :customers
  devise_for :owners
  root 'home#index'
  resources :buffets, only: %i[index show new create edit update]
  resources :events, only: %i[show new create edit update destroy] do
    resources :event_costs, only: %i[new create edit update]
  end
end
