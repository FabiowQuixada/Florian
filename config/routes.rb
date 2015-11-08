Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, controllers: { registrations: "registrations" }

  scope "/admin" do
    resources :users, except: [:show, :destroy] do

      member do
        post 'activate'
        post 'inactivate'
      end
    end

    resources :roles, except: [:show, :destroy] do

      member do
        post 'activate'
        post 'inactivate'
      end
    end

  end

  resources :companies, except: [:show, :destroy] do

    member do
      post 'activate'
      post 'inactivate'
    end
  end

  resources :email_configuration, only: [:edit, :update]

  resources :emails, except: [:show, :destroy] do

    collection do
      post 'resend_all'
    end

    member do
      post 'resend'
      post 'send_test'
      post 'activate'
      post 'inactivate'
    end
  end

  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"

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
