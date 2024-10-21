Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  namespace :admin do
    root "homes#top"
  end

  scope module: :public do
    root "homes#top"
    get "homes/about" => "homes#about", as: 'about'
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resources :favorites
    end
    resources :users, only: [:show, :edit, :update, :destroy]
  end
end
