Rails.application.routes.draw do
  resources :enrollments do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end
  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons do
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'privacy_policy', to: "static_pages#privacy_policy"
  get 'activity', to: "static_pages#activity"
  get 'analytics', to: "static_pages#analytics"
  get 'charts/users_per_day', to: "charts#users_per_day"
  get 'charts/enrollments_per_day', to: "charts#enrollments_per_day"

  root "static_pages#landing_page"
end
