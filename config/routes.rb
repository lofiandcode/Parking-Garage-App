Rails.application.routes.draw do
  resources :user_cars #, :except => [:new]
  #get '/user_cars/:id/new', to: 'user_cars#new', as: 'new_user_car'
  resources :garages
  resources :spaces
  resources :cars
  resources :families
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
