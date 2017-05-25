Rails.application.routes.draw do
  root to: "static_pages#home"
  devise_for :users

  namespace :admin do
    resources :users
    resources :films
    resources :categories
    resources :films
    resources :scripts
  end

  resources :scripts
  resources :static_pages
  resources :users
  resources :likes
  resources :relationships
end
