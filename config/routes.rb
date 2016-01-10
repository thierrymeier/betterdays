Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root                  'entries#index'
  get   'signup'    =>  'users#new', as: 'signup'
  get   'login'     =>  'sessions#new', as: 'login'
  post  'login'     =>  'sessions#create'
  get   'logout'    =>  'sessions#destroy', as: 'logout'
  resources :sessions
  resources :charges
  resources :users,                 except: [:index, :show, :destroy]
  resources :account_activations,   only: [:edit]
  resources :password_resets,       only: [:new, :create, :edit, :update]
  resources :entries do
    collection do
      post :search
    end
  end
  
end
