Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'users/corporations', to: 'users#corporations', as: 'user_corporations'
      post 'users/corporations', to: 'users#add_corporation', as: 'user_add_corporation'
      put 'users', to: 'users#update', as: 'current_user_update'
      patch 'users/:id', to: 'users#change_status', as: 'user_change_status'
      resources :users, except: %i[new edit update destroy]

      get 'corporations/current', to: 'corporations#current', as: 'current_corporation'
      post 'corporations/current', to: 'corporations#select', as: 'select_corporation'
      put 'corporations', to: 'corporations#update', as: 'update_corporation'
      patch 'corporations/:id', to: 'corporations#change_status', as: 'corporation_change_status'
      resources :corporations, except: %i[new destroy update edit]

      post 'auth', to: 'authentication#create'
      get 'auth', to: 'authentication#show'
      delete 'auth', to: 'authentication#destroy'
    end
  end
end
