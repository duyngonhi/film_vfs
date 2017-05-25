Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users

  namespace :admin do
    resources :users
    resources :films
    resources :categories
    resources :films
  end

  resources :scripts
  resources :static_pages
end
