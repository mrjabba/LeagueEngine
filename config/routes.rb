ActionController::Routing::Routes.draw do |map|
  map.login 'login', :controller => 'user_session', :action => 'new'
  map.logout 'logout', :controller => 'user_session', :action => 'destroy'
  map.signup 'signup', :controller => 'account', :action => 'index'    

  map.namespace(:admin) do |admin|
    admin.resources :leagues
    admin.resources :games
  end
  
  map.resources :accounts
  map.resources :user_sessions
  map.resources :users
  
  
  map.root :controller => 'admin/leagues', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
