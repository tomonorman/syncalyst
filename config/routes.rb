Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :meetings, only: [:index, :show, :edit] do
    resources :attendances, only: [:create]
    resources :agendas, only: [:create]
    resources :tasks, only: [:create]
  end
  resources :attendances, only: [:edit]
  resources :agendas, only: [:edit, :start, :finish]
end
