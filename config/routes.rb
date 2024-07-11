Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :api do
    namespace :v1 do
      resources :roadmaps, only: [:index, :show, :create, :update, :destroy] do
        resources :steps, only: [:index, :create] do
          post 'batch_steps', on: :collection
        end
      end
      resources :categories, only: [:index, :show]
      resources :steps, only: [:show, :update, :destroy]
    end
  end
end
