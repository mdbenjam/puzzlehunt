Rails.application.routes.draw do
  devise_for :users
  resources :puzzles, only: [:index, :show] do
    resources :answers, only: [:index, :create]
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "puzzles#index"
end
