Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
end
