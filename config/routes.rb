Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'users/corporations', to: 'users#corporations', as: 'user_corporations'
      get 'users/current', to: 'users#current', as: 'current_user'
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

      resources :payment_conditions, excep: %i[new edit]

      patch 'orders/:id/approval', to: 'orders#change_approval', as: 'order_change_approval'
      patch 'orders/:id/status', to: 'orders#change_status', as: 'order_change_status'
      patch 'orders/:id/status_next', to: 'orders#change_status_next', as: 'order_change_status_next'
      patch 'orders/:id/status_previous', to: 'orders#change_status_previous', as: 'order_change_status_previous'
      get 'orders/:id/history', to: 'orders#history', as: 'order_history'
      resources :orders, except: %i[new edit destroy]

      namespace :settings do
        get 'modules', to: 'modules#index', as: 'settings_modules'
      end

      post 'auth', to: 'authentication#create'
      get 'auth', to: 'authentication#show'
      delete 'auth', to: 'authentication#destroy'
    end
  end
end
