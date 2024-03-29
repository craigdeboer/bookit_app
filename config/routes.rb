Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'contact' => 'static_pages#contact'
  get    'help'    => 'static_pages#help'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  put 'booking' => 'bookings#update'
  post 'create_booking' => 'bookings#create'

  delete 'delete_booking' => 'bookings#destroy'
  patch 'update_user_booking' => 'bookings#update'

  get    'signup'  => 'users#new'

  get    'wheelchair_search' => 'wheelchairs#search'

  post 'import_powerchairs' => 'powerchairs#import'
  
  resources :users do
    resources :bookings
  end
  resources :wheelchairs do
    resources :bookings, :defaults => { bookable: "wheelchair" }
  end
  resources :powerchairs do
    resources :bookings, :defaults => { bookable: "powerchair" }
  end
  resources :scooters do
    resources :bookings, :defaults => { bookable: "scooter" }
  end
  resources :mattresses do
    resources :bookings, :defaults => { bookable: "mattress" }
  end
  resources :others do
    resources :bookings, :defaults => { bookable: "other" }
  end

  resources :accounts



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
