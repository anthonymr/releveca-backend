Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :users, except: %i[new edit show]

      post 'auth', to: 'authentication#create'
      get 'auth', to: 'authentication#show'
      delete 'auth', to: 'authentication#destroy'
    end
  end
end
