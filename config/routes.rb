Rails.application.routes.draw do
  devise_for :users

  resources :developments do
    resources :reviews do
      resources :scores
      resources :comments
    end
  end

  resources :score_types, only: [:index, :show]

  get "home", to: "pages#home"
  get "about-us", to: "pages#about"

  root 'pages#about'
end
