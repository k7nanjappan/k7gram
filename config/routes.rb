Rails.application.routes.draw do

  #get 'posts/index'
  get 'users/explore'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


  #root to: redirect("/#{I18n.locale}/posts/")
  #root :to => redirect("/#{I18n.locale}/posts")
   #root :to =>'posts#index'
   #root :to =>'pages#home'
   root :to =>'posts#index'
   #root :to =>'users#show'






  devise_for :users, skip: :omniauth_callbacks,
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}


  #get '/users/:id', to: 'users#show '

  resources :users, only: [:index,  :show] do
    resources :avatar, only: [:create]
  end

  resources :friendships, only: [:create, :destroy]

  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy], shallow: true
    resources :bookmarks, only: [:create, :destroy], shallow: true
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end
