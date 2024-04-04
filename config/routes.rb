Rails.application.routes.draw do
  resources :homes do
    resources :blogs, param: :address
  end
  resources :posts
  resources :blogs, param: :address do
    resources :posts
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homes#about"
end
