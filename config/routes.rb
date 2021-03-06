Rails.application.routes.draw do

  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  resources :friends do
    collection do
      get :box
    end
    member do
      get :ask
      get :accept
      get :remove
      get :reject

    end
  end
  resources :profiles do

    member do
      get :like_list
      get :faverite_list
    end
  end

  resources :dishes do
    resources :comments, :controller => 'dish_comments'

    collection do
        #get :faverite_list
        get :draft
    end

    member do
      post :faverite
      get :like
    end
  end

  namespace :admin do
    resources :tags
    resources :dishes do
      resources :comments,:controller=>'dish_comments'
      collection do
          get :draft
      end

    end
  end

  #home controllers
  get 'about' =>'homes#about'


  get 'user_list'=>'profiles#user_list'
  #get 'profile/:name/'=>'profiles#show'
  get 'faverite_list/:id'=>'dishes#faverite_list', :as=>:faverite_list
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homes#index'
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
