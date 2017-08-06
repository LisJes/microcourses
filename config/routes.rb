Rails.application.routes.draw do

  devise_for :users
  root 'events#index'
  #LIJ: change the landing page from rails default to my index
  resources :events
end
