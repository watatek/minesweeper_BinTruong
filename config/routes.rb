Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :boards, only: [:index, :new, :create, :show]
  get '/home', to: 'home#dashboard'
  root "boards#new"
end
