Gamelog::Application.routes.draw do
  devise_for :users

  resources :characters
  resources :campaigns, :except => [:index, :destroy]

  root :to => 'users#show'
end
