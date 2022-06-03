Rails.application.routes.draw do

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
    root 'homes#top'
    get 'about' => 'homes#about', as: 'about'

    get 'end_users/mypage' => 'end_users#show', as: 'mypage'
    get 'end_users/information/edit' => 'end_users#edit', as: 'edit_information'
    patch 'end_users/information' => 'end_users#update', as: 'update_information'
    get 'end_users/unsubscribe' => 'end_users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw_end_user'
    get 'search' => 'serches/search'

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:create, :destroy]
    resources :groups do
      resources :group_end_users, only: [:create, :destroy]
      resources :event_notices, only: [:new, :create]
      get 'event_notices/sent' => 'event_notices#sent', as: 'sent'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
