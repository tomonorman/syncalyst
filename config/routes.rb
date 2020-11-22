Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'pages#home'

  get 'meetings/:id/summary', to: 'meetings#summary', as: :meeting_summary
  put 'meetings/:id/start', to: 'meetings#start', as: :start_meeting
  put 'meetings/:id/finish', to: 'meetings#finish', as: :finish_meeting
  resources :meetings, only: [:index, :show, :edit, :create, :new] do
    resources :agendas, only: [:create]
    resources :tasks, only: [:create]
  end
  resources :attendances, only: [:edit]

  resources :agendas, only: [:edit, :start, :finish, :update]
  post 'meetings/:id/:user_id', to: 'attendances#create', as: :invite_attendance
end
