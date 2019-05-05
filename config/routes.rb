Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
      end 
      resources :merchants, only: [:index, :show] do
        scope module: :merchants do 
          resources :items, only: [:index]
          resources :invoices, only: [:index]
          get '/revenue', to: 'revenue#show'
          get '/favorite_customer', to: 'favorite_customer#show'
        end
      end 

      namespace :items do 
        get '/find', to: 'search#show' #no test yet 
        get '/find_all', to: 'search#index' #no test yet 
        get '/random', to: 'random#show' #no test yet 
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end 
      resources :items, only: [:index, :show] do 
        scope module: :items do 
          get '/best_day', to: 'best_day#show'
        end 
      end 

      namespace :customers do 
        get '/find', to: 'search#show' #no test yet 
        get '/find_all', to: 'search#index' #no test yet 
        get '/random', to: 'random#show' #no test yet 
      end
      resources :customers, only: [:index, :show] do
        scope module: :customers do 
          get 'favorite_merchant', to: 'favorite_merchant#show'
        end 
      end 
    end 
  end
end
