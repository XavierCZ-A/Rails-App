Rails.application.routes.draw do
  resources :categories, except: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :products, path: '/'
  # resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # get "products/new" => "products#new", as: :new_product
  # get "products" => "products#index"
  # get "products/:id" => "products#show", as: :product
  # post "products" => "products#create"
  # get "products/:id/edit" => "products#edit", as: :edit_product
  # patch "products/:id" => "products#update"
  # delete "products/:id" => "products#destroy"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
