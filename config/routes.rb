Rails.application.routes.draw do
  
  namespace :site do
    get 'welcome/index'
  end

  namespace :users_backoffice do
    get 'welcome/index'
  end

  namespace :admins_backoffice do
    get 'welcome/index'
  end

  devise_for :users
  devise_for :admins
  
  get 'inicio', to: 'site/welcome#index'
  get 'backoffice', to: 'admins_backoffice/welcome#index'
  
  root to: 'site/welcome#index'

  devise_scope :user do
    get '/entrar' => 'devise/sessions#new'
    get '/sair' => 'devise/sessions#destroy'
  end

  devise_scope :admin do
    get '/entrar' => 'devise/sessions#new'
    get '/sair' => 'devise/sessions#destroy'
  end

end
