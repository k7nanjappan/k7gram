Rails.application.routes.draw do
  #get 'pages/home'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do


  # root to: redirect("/#{I18n.locale}/posts")
  # root :to => redirect("/#{I18n.locale}/posts")
   root :to =>'posts#index'






  devise_for :users, skip: :omniauth_callbacks,
  path: '',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
  controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}


  #get '/users/:id', to: 'users#show '

  resources :users, only: [:show]

  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end
