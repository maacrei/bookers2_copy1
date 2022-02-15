Rails.application.routes.draw do
  root to:"homes#top"
  devise_for :users
  resources :books
  # resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  # 全部のアクションがあるからonlyはいらない
  resources :users, only: [:index, :show, :edit, :update]
  get 'home/about' => "homes#about",as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
