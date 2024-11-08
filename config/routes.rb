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
    resources :users, only: :destroy
  end

  scope module: :public do
    root "homes#top"
    get "homes/about" => "homes#about", as: 'about'
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorite, only:[:create, :destroy]
    end
    resources :users do
      collection do
        get 're_sign_in', to: 'users#re_sign_in'
        patch 're_sign_in', to: 'users#update_re_sign_in'
        get '/search', to: 'searches#search'
      end
    end
  end
end
