RpgTracker::Application.routes.draw do
  devise_for :users

  resources :campaigns, :except => [:destroy] do
    resources :invitations, :only => [:new, :create]
    resources :characters,  :only => [:new, :create]
  end
  resources :characters,  :only => [:show, :edit, :update]

  root :to => 'users#show'
end
