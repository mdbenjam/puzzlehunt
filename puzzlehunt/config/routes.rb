Rails.application.routes.draw do
  devise_for :users
  get 'puzzles/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "puzzles#index"
end
