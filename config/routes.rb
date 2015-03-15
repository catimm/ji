Code::Application.routes.draw do
  mount Surveyor::Engine => "/surveys", :as => "surveyor"
  
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" },
  controllers: { omniauth_callbacks: "authentications", registrations: "registrations", invitations: "invitations"  }

  devise_scope :user do
    delete "/logout" => "devise/sessions#destroy"
  end
  
  resources :users

  resources :explorations, :path => "exploring" do
    resources :problems   
  end
  
  root :to => 'home#index'
  get 'privacy' => 'home#privacy'
  get 'terms' => 'home#terms'
  get 'input/record' => 'input#record', :as => 'record', :path => "/record"

  post 'users/:id' => 'users#update'
  post 'users/new' => 'users#update'
  get  "/problems" => 'problems#show'
  post "exploring/:exploration_id/problems/:id" => 'problems#update', :as => 'project_update_feedback'
  get "exploring/:exploration_id/problems/:id/update" => 'problems#update', :as => 'project_update_from_survey'
 
  post "/surveys/:survey_code" => 'surveyor#create'
 
  get   "/devise/invitations/new"
    
  match '/video/new' => 'input#video_url', :via => [:post]
  get "/input/view_video_info" => 'input#view_video_info'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
