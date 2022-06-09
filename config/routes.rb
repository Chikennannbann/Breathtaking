Rails.application.routes.draw do

  devise_scope :end_user do
    post 'end_users/guest_sign_in' => 'end_users/sessions#guest_sign_in'
  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show] do
      resources :post_comments, only: [:destroy]
    end
  end

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root 'posts#index'
    get 'about' => 'homes#about', as: 'about'

    get 'end_users/unsubscribe' => 'end_users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw_end_user'
    get 'search' => 'searches#search'

    resources :end_users, only: [:show, :edit, :update]
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :groups do
      resources :group_end_users, only: [:create, :destroy]
      resources :event_notices, only: [:new, :create]
      get 'event_notices/sent' => 'event_notices#sent', as: 'sent'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
