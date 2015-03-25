Rails.application.routes.draw do
  root 'posts#index'
  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'

  get 'sign-out', to: 'authentication#destroy'
  get 'sign-in', to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
end
