ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'leagues', :action => 'index'
  map.login 'login', :controller => 'user_session', :action => 'new'
  map.logout 'logout', :controller => 'user_session', :action => 'destroy'  
  
  map.resources :accounts
  map.resources :leagues do |league|
    league.resources :teams
  end
  map.resources :teams, :member => {:confirm_destroy => :get}
  map.resources :games
  map.resources :user_sessions
  map.resources :users
  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
