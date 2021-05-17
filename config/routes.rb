Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :courses do
    resources :lessons
  end
  resources :users, only: [:index, :edit, :show, :update]
  get 'privacy_policy', to: "static_pages#privacy_policy"
  get 'activity', to: "static_pages#activity"
  root "static_pages#landing_page"
end
