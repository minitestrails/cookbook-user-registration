Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :recipes
  root "recipes#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
