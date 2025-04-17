Rails.application.routes.draw do
  namespace :admin do
    get "dashboard", to: "dashboard#index"

    resources :posts do
      resources :contents
    end

    resources :blogs, param: :address do
      resources :posts
    end
  end

  # PUBLIC (No Create, update, destroy)
  resources :posts, except: %i[new create update destroy] do
    resources :contents, except: %i[new create update destroy]
  end

  resources :blogs, except: %i[new create update destroy] do
    resources :posts, except: %i[new create update destroy]
  end

  get "homes/:id/make_active", to:"homes#make_active", as: :make_active

  root "homes#about"
end
