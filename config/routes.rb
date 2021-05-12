Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [:index]
  get 'privacy_policy', to: "static_pages#privacy_policy"
  get 'activity', to: "static_pages#activity"
  root "static_pages#landing_page"
end
