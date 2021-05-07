Rails.application.routes.draw do
  devise_for :users
  resources :courses
  root "static_pages#landing_page"
  get 'privacy_policy', to: "static_pages#privacy_policy"
end
