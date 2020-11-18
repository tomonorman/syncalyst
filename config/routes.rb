Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  put 'meetings/:id/start', to: 'meetings#start', as: :start_meeting
  put 'meetings/:id/finish', to: 'meetings#finish'
  resources :meetings, only: [:index, :show, :edit, :create, :new] do
    resources :attendances, only: [:create]
    resources :agendas, only: [:create]
    resources :tasks, only: [:create]
  end
  resources :attendances, only: [:edit]
  resources :agendas, only: [:edit, :start, :finish]
end
