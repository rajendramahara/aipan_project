Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "pages#home"

  resource :dashboard, only: [:show]
  resource :registration, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resource :password_reset, only: %i[new create edit update]
  resources :users, only: %i[show edit update]

  resource :invitation, only: %i[update] do
    collection do
      get :accepts
    end
  end

  resources :organizations, except: %i[index] do
    resources :projects, module: :organizations, only: %i[index show new create]
    resources :memberships, module: :organizations
    resources :announcements, module: :organizations
    resources :departments, module: :organizations do
      collection do
        patch :update_department_user
      end
    end
    resources :roles, module: :organizations
  end
end
