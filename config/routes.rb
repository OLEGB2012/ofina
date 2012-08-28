Ofina::Application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  devise_for :users, :controllers => {registrations: 'registrations'}
  root to: 'static_pages#home'  
  
  match '/help'              , to: 'static_pages#help'
  match '/about'             , to: 'static_pages#about'  
  match '/contact'           , to: 'static_pages#contact'
  match '/news'              , to: 'static_pages#news'
  match '/normativ'          , to: 'static_pages#normativ'
  match '/glossary'          , to: 'static_pages#glossary'
  match '/calc_prompt'       , to: 'calculations#prompt'
  match '/calc_run'          , to: 'calculations#run'
  match '/results'           , to: 'results#index'
  match '/results_ab_table'  , to: 'results#ab_table'
  match '/results_ab_graph'  , to: 'results#ab_graph'
  match '/results_fu_table'  , to: 'results#fu_table'
  match '/results_fu_graph'  , to: 'results#fu_graph'
  match '/results_lp_table'  , to: 'results#lp_table'
  match '/results_lp_graph'  , to: 'results#lp_graph'
  match '/results_da_table'  , to: 'results#da_table'
  match '/results_da_graph'  , to: 'results#da_graph'
  match '/results_ren_table' , to: 'results#ren_table'
  match '/results_ren_graph' , to: 'results#ren_graph'
  match '/user'              , to: 'users#edit'
  
  resources :enterprises do
#    shallow do
      resources :form_one_reports
      resources :form_two_reports
      resources :form_three_reports
      resources :form_four_reports
#    end         
  end  
  
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
