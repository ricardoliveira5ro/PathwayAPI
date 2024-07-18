Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      root to: 'base#index'
      
      devise_scope :user do
        post 'signup', to: 'users/registrations#create'
        post 'login', to: 'users/sessions#create'
        delete 'logout', to: 'users/sessions#destroy'
      end
      
      resources :roadmaps, only: [:index, :show, :create, :update, :destroy] do
        resources :steps, only: [:index, :create] do
          post 'batch_steps', on: :collection
        end
      end
      resources :categories, only: [:index, :show]
      resources :steps, only: [:show, :update, :destroy]
    end


    #---------------------------------------------------------------------------


    namespace :v2 do
      root to: 'base#index' 

      devise_scope :user do
        post 'signup', to: 'users/registrations#create'
        post 'login', to: 'users/sessions#create'
        delete 'logout', to: 'users/sessions#destroy'
      end

      resources :roadmaps, only: [:index, :show, :create, :update, :destroy] do
        resources :steps, only: [:index, :create] do
          post 'batch_steps', on: :collection
        end
      end
      resources :categories, only: [:index, :show]
      resources :steps, only: [:show, :update, :destroy] do
        resources :tracker, only: [:create]
      end
    end
  end
end
