ActionController::Routing::Routes.draw do |map|
  #map.resources :movements
  map.filter 'locale'
  map.resources :bankaccounts  , :has_many => :movements
  map.resources :loanaccounts  , :has_many => :movements
  map.resources :creditcardaccounts  , :has_many => :movements
  map.resources :categories  , :has_many => :movements
  map.resources :tags
  map.resources :password_resets
  map.resources :shared_account_invitations, :as => 'sharedaccount' ,:member => {:accept =>:get},:only => [:accept]
  map.resources :bankaccounts, :has_many => :shared_account_invitations 
  map.resources :bankaccounts, :has_many => :accounts_users 
  map.accounts '/accounts',:controller => 'accounts', :action => 'index'
 
  
  map.quickmovement '/quickmovement', :controller => "movements" ,:action => "quickcreate", :conditions => { :method => [:post] } 
  map.quickmovement '/quickmovement', :controller => "movements" ,:action => "quicknew", :conditions => { :method => [:get] } 
  map.dashboard '/dashboard',:controller => "dashboard", :action => "index" 
  map.root :dashboard
   
  
   # optional, this just sets the root route
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'  
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.resource :user_session
  map.resource :account,  :controller => "users"
  map.resources :users 

  #map.resources :bankaccounts

  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  end
  #ActionController::Routing::Translator.i18n('pt')
  #ActionController::Routing::Translator.translate_from_file('config/locales','i18n-routes.yml')