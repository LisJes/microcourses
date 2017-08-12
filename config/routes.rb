Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show]
  #LIJ: Idea is to have a index page for all courses of a given users, thus we here only want show. After adding this run rake routes and grep users to see what is available to work with

  root 'events#index'
  #LIJ: change the landing page from rails default to my index
  resources :events

end
