Rails.application.routes.draw do
  root to: 'static_pages#home'
  devise_for :users

  namespace :admin do
    resources :users
  end

  namespace :admin do
    resources :films
  end
end
