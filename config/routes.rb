Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
    passwords: 'public/users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end

  namespace :admin do
    root "homes#top"
    resources :users, only: [:show, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  scope module: :public do
    root "homes#top"
    get "homes/about" => "homes#about", as: 'about'
    resources :posts do
      #get "posts/new" => "posts#new", as: 'new_post' 7個分展開される
      #:以降は丸括弧（引数）が存在している
      #左に:があるものはシンボルになる
      resources :comments, only: [:create, :destroy]
      #post "posts/:post_id/comments" => "comments#create", as: 'post_comments' onlyオプションで2個分展開される
      #onlyはハッシュになる。波括弧が省略されている。
      #:commentsが第一引数
      resource :favorite, only:[:create, :destroy]
      #:idがつかない、indexがないので6つのアクションになる
    end

    resources :groups do
      resource :group_users, only:[:create, :destroy]
    end

    resources :users do
      resources :favorites, only:[:index]
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      collection do
        get 're_sign_in', to: 'users#re_sign_in'
        patch 're_sign_in', to: 'users#update_re_sign_in'
        get '/search', to: 'searches#search'
      end
    end

    resources :group_users, only: [:update]
    resources :notifications, only: [:update]
    resources :chats, only: [:show, :create, :destroy]
  end
end
