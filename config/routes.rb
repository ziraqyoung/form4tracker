# == Route Map
#

Rails.application.routes.draw do
  root 'landing#index'

  resources :charts, only: :index
  resources :companies, only: [:index, :show]

  # api/prices?company_id=1
  namespace :api do
    resources :prices
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
