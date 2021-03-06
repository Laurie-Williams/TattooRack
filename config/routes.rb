Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Users
  devise_for :users,
             #Overide Devise controller with customised users/registrations controller
             controllers: { registrations: "users/registrations" }
  resources :users, only: [:index, :edit, :update, :show, :destroy]

  # Pieces
  get 'pieces/crop'
  resources :pieces, only: [:index, :new, :create, :edit, :update, :show, :destroy]do
    resources :comments, only: [:create, :destroy]
    resources :tags, only: [:create, :destroy]
    post "like", to: "votes#like"
    delete "like", to: "votes#unlike"
  end

  # Tags
  get "pieces/tags/:tag", to: "tags#show", as: "pieces_tag"
  get "tags", to: "tags#index"

  # Search
  get "search", to: "search#search"

  # Notifications
  get "notifications", to: "notifications#index"
  get "notifications/count", to: "notifications#count"
  post "notification/:id/viewed", to: "notifications#viewed", as: "notification_viewed"

  # Home
  root "pieces#index"

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
