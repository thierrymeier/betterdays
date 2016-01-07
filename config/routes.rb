Rails.application.routes.draw do
  resources :sessions
  resources :users, except: [:index, :show, :destroy]
  resources :entries do
    collection do
      post :search
    end
  end

  root                  'entries#index'
  get   'new'       =>  'entries/new'
  get   'show'      =>  'entries/show'
  get   'edit'      =>  'entries/edit'
  get   'search'    =>  'entries/search'
  get   'signup'    =>  'users#new', as: 'signup'
  get   'login'     =>  'sessions#new', as: 'login'
  post  'login'     =>  'sessions#create'
  get   'logout'    =>  'sessions#destroy', as: 'logout'

end
