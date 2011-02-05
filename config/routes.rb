Gamelog::Application.routes.draw do
  resources :characters
  resources :campaigns, :except => [:index, :destroy]
  resource  :user, :only => [:show, :new, :create]

  root :to => 'users#show'
end
