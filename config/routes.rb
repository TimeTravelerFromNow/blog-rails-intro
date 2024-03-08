Rails.application.routes.draw do
  get 'content/update'
  get 'content/destroy'
  resources :posts do
    resources :content
  end
  resources :blogs, param: :address do
    resources :posts
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "blogs#index"
end
