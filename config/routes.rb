Rails.application.routes.draw do
  devise_for :users

  resources :developments do
    resources :reviews, only: [:create, :update, :destroy] do
      resources :scores, only: [:create, :update, :destroy]
      resources :comments, only: [:create, :update, :destroy]
    end
  end

  resources :score_types, only: [:index, :show]

  root 'developments#index'
end
