Rails.application.routes.draw do
  root 'landing#index'

  resources :charts, only: :index

  # api/prices?company_id=1
  namespace :api do
    resources :prices
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"
end
