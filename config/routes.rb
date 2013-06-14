Facemate::Application.routes.draw do
	root to: "users#index" 

  devise_for :users 

  resources :users, only: [:index, :show, :edit, :update] do
  	resources :photos, only: [:index, :show]
  	resources :messages
    resources :likings
    resources :shunnings
  end

  resources :types

  resources :photos

  resources :messages

  resources :visits

  resources :ratings

  resources :feedbacks

  resources :likings

  resources :shunnings


  match "/users/:id/profile" => "users#profile_edit"
  match "/face_matches" => "users#face_matches"
  match "/browse" => "users#browse"
  match "/blacklist" => "users#blacklist"
end
