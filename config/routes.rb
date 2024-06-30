Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :books, only:[:new, :index, :show, :destroy, :create, :edit, :update]
  resources :users, only:[:edit, :index, :show, :update]
end
