Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'users/corporations', to: 'users#corporations', as: 'user_corporations'
      post 'users/corporations', to: 'users#add_corporation', as: 'user_add_corporation'
      resources :users, except: %i[new edit show]

      get 'corporations/current', to: 'corporations#current', as: 'current_corporation'
      post 'corporations/select', to: 'corporations#select', as: 'select_corporation'
      patch 'corporations', to: 'corporations#update', as: 'update_corporation'
      resources :corporations, except: %i[new destroy edit]

      post 'auth', to: 'authentication#create'
      get 'auth', to: 'authentication#show'
      delete 'auth', to: 'authentication#destroy'
    end
  end
end
