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


  get "home", to: "pages#home"
  get "about-us", to: "pages#about"

  root 'pages#about'
end
