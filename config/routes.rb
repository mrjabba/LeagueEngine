LeagueEngine::Application.routes.draw do
  match 'login' => 'user_sessions#new', :as => 'login'
  match 'logout' => 'user_sessions#destroy', :as => 'logout'
  match 'signup' => 'accounts#new', :as => 'signup'

  namespace "admin" do
    resources :leagues
    resources :games
  end
  
  resources :accounts, :only => [:new, :create]
  resources :user_sessions
  resources :users

  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'

  #root :to => 'welcome#index'
end