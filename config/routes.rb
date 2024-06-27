Rails.application.routes.draw do
  get 'search/index'
  devise_for :users

  resources :search, only: [ :index ]
  # resources :score_types, only: [:index, :show]

  resources :developments do
    resources :reviews do
      resources :scores
      resources :comments
    end
  end
  # Define a custom route for rendering description
  get '/developments/:id/render_description', to: 'developments#render_description', as: 'render_description'
  namespace :moderator do 
    resources :developments do
      resources :reviews do
        resources :scores
        resources :comments
      end
    end
  end
  # Moderation
  resources :moderator, only: %i[ index ]
  resources :admin, only: %i[ index ]
  # get 'admin', to: 'admin_panel#index'

  # Pages
  get "home", to: "pages#home"
  get "about-us", to: "pages#about"
  get "contact", to: "pages#contact"

  root 'pages#about'
end
