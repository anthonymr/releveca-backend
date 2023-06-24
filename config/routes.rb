Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'users/corporations', to: 'users#corporations', as: 'user_corporations'
      post 'users/corporations', to: 'users#add_corporation', as: 'user_add_corporation'
      put 'users', to: 'users#update', as: 'current_user_update'
      patch 'users/:id/status', to: 'users#change_status', as: 'user_change_status'
      resources :users, except: %i[new edit update destroy]

      get 'corporations/current', to: 'corporations#current', as: 'current_corporation'
      post 'corporations/current', to: 'corporations#select', as: 'select_corporation'
      get 'corporations/items', to: 'corporations#items', as: 'corporation_items'
      put 'corporations', to: 'corporations#update', as: 'update_corporation'
      patch 'corporations/:id/status', to: 'corporations#change_status', as: 'corporation_change_status'
      resources :corporations, except: %i[new destroy update edit]

      patch 'items/:id/status', to: 'items#change_status', as: 'item_change_status'
      patch 'items/:id/stock', to: 'items#change_stock', as: 'item_change_stock'
      resources :items, except: %i[new edit destroy]

      resources :countries, only: %i[create index destroy]

      patch 'clients/:id/approval', to: 'clients#change_approval', as: 'client_change_approval'
      patch 'clients/:id/status', to: 'clients#change_status', as: 'client_change_status'
      patch 'clients/:id', to: 'clients#patch', as: 'client_patch'
      put 'clients/:id', to: 'clients#update', as: 'client_update'
      resources :clients, only: %i[create index show]

      resources :currencies, excep: %i[new edit]

      post 'auth', to: 'authentication#create'
      get 'auth', to: 'authentication#show'
      delete 'auth', to: 'authentication#destroy'
    end
  end
end
