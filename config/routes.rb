Rails.application.routes.draw do
  resources :tasks
  resources :task_schedules do
    post 'add_task', on: :member
  end
  resources :users
  root to: 'users#index'
end
