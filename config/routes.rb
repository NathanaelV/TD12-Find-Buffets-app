Rails.application.routes.draw do
  devise_for :customers, path: 'customers', controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }
  devise_for :owners, path: 'owners', controllers: {
    sessions: 'owners/sessions',
    registrations: 'owners/registrations'
  }
  root 'home#index'
  resources :buffets, only: %i[index show new create edit update]

  resources :events, only: %i[show new create edit update destroy] do
    resources :event_costs, only: %i[new create edit update]
    resources :orders, only: %i[new create]
  end

  resources :orders, only: %i[show index] do
    resources :proposals, only: %i[show new create] do
      patch :accept, on: :member
    end
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: %i[index]
    end
  end
end
