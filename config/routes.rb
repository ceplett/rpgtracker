RpgTracker::Application.routes.draw do
  devise_for :users

  resources :campaigns, :except => [:destroy] do
    resources :characters, :except => [:index, :destroy]
  end

  root :to => 'users#show'
end
