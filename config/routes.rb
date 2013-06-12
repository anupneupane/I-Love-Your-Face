Facemate::Application.routes.draw do
	root to: "users#show" 

  devise_for :users 

  resources :users, only: [:index, :show] do
  	resources :photos, only: [:index, :show]
  	resources :messages
  end

  resources :types

  resources :photos

  resources :messages

  resources :visits
end
