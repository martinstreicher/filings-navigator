Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :filers, only: %i[show index] do
    resources :filings, only: %i[show index]
  end

  resources :filings, only: %i[show index] do
    resources :awards, only: %i[show index]
  end

  resources :recipients, only: %i[show index]
end
