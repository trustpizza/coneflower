Rails.application.routes.draw do
  devise_for :users

  resources :developments do
    resources :reviews do
      resources :scores
      resources :comments
    end
  end
  # Define a custom route for rendering description
  get '/developments/:id/render_description', to: 'developments#render_description', as: 'render_description'

  resources :score_types, only: [:index, :show]

  get "home", to: "pages#home"
  get "about-us", to: "pages#about"

  root 'pages#about'
end
