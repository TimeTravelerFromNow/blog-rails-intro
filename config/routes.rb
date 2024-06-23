Rails.application.routes.draw do
  get 'contents/create'
  get 'contents/update'
  get 'contents/destroy'
  resources :ext_links
  resources :homes do
    resources :blogs, param: :address
  end

  resources :posts do
    resources :contents
  end

  resources :blogs, param: :address do
    resources :posts
  end

  get "homes/:id/make_active", to:"homes#make_active", as: :make_active
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homes#about"
end
