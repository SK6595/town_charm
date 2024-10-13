Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
  end
  
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }
  
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }
  
  scope module: :public do
    root "homes#top"
    resources :posts do
      resources :comments
      resources :favorites
    end
  end

  namespace :admin do
    root "homes#top"
  end
end
