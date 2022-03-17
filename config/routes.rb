Rails.application.routes.draw do
  resources :puzzle_hunts, only: %i[index show]

  devise_for :users
  resources :puzzles, only: [:show] do
    get :show_content, on: :member
    get '*file' => :show_content, :on => :member
    resources :answers, only: %i[index create]
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get 'health', to: 'application#health'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'puzzle_hunts#index'
end
