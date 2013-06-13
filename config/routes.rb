Facemate::Application.routes.draw do
	root to: "users#index" 

  devise_for :users 

  resources :users, only: [:index, :show] do
  	resources :photos, only: [:index, :show]
  	resources :messages
    resources :likings
    resources :shunnings
    resources :profiles
  end

  resources :types

  resources :photos

  resources :messages

  resources :visits

  resources :ratings

  resources :feedbacks

  resources :likings

  resources :shunnings

end
