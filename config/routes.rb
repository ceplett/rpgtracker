Gamelog::Application.routes.draw do
  resources :characters
  resources :campaigns, :except => [:index, :destroy]
  resource  :user, :only => [:show, :new, :create]
  resource  :user_session, :only => [:new, :create, :destroy]

  root :to => 'users#show'
end
