Rails.application.routes.draw do
  post 'set_location', to: 'locations#set'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Users Scopes
  scope module: "users" do 
    resources :profiles, only: %i[ show update edit ]

    resources :search, only: [ :index ]
    
    get '/developments/:id/render_description', to: 'developments#render_description', as: 'render_description'

    resources :developments, only: %i[ index show ] do
      resources :reviews do
        resources :scores
        resources :comments
      end
    end
  end
  
  # Moderation
  resources :moderator, only: %i[ index ]
  # Moderator Links
  namespace :moderator do
    resources :search, only: [ :index ]
    resources :developments do
      member do 
        patch :toggle_published
      end
      resources :reviews do
        resources :scores
        resources :comments
      end
    end
    # User management
    resources :users, only: %i[ index show ] do 
      member do
        patch :toggle_ban
      end
    end
  end


  # get 'admin', to: 'admin_panel#index'

  # Pages
  get "home", to: "pages#home"
  get "about_us", to: "pages#about"
  get "contact", to: "pages#contact"

  root 'pages#about'
end
