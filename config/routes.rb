ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.signup 'signup', :controller => 'account', :action => 'index'    

  map.namespace(:admin) do |admin|
    admin.resources :leagues
    admin.resources :games
  end
  
  map.resources :accounts, :only => [:new, :create]
  map.resources :user_sessions
  map.resources :users
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
