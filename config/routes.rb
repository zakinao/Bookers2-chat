Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :rooms, only: [:index, :create, :show]
  resources :chats, only: [:create, :edit, :update, :destroy]
  resources :books
end