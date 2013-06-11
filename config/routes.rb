Facemate::Application.routes.draw do
	root to: "users#show" 

  devise_for :users 

  resources :users, only: [:index, :show] do
  	resources :photos, only: [:index, :show]
  end

  resources :types
  resources :photos
end
