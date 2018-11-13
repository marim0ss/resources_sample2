Rails.application.routes.draw do

  # ログインページへのルート
  get 'login', to: 'users#login_form'
  # 入力された値を保存する
  post 'login', to: 'users#login'

  # ログアウト
  post 'logout', to: 'users#logout'


  resources :users
end
