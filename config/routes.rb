Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'

  # Facebook login
  get "/:provider/login"  => "sessions#new"
  get "/logout" => "sessions#destroy"
  get "/auth/:provider/callback" => "sessions#create" unless Rails.env.development?
  post "/auth/:provider/callback" => "sessions#create" if Rails.env.development?
  get "/auth/failure" => "sessions#failuer"

  # web
  resources :places do
    resources :photos
  end
  resources :users

  # api
  namespace :api do
    resources :places do
      resources :photos
    end
  end

  # admin
  namespace :admin do
    resources :places
  end
end
