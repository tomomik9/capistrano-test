Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  resources :reports do
    resources :comments
  end
  resources :books do
    resources :comments
  end
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions', 
  omniauth_callbacks: "users/omniauth_callbacks"
 }
  scope "(:locale)" do
    resources :reports
  end
   scope "(:locale)" do
    resources :books
  end
  resources :relationships, only: [:create, :destroy]
  resources :users do
    resources :followings, only: [:index]
  end
  resources :users do
    resources :followers, only: [:index]
  end
  if Rails.env.development? #開発環境の場合
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
