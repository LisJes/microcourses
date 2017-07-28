Rails.application.routes.draw do

  root 'events#index'
  #change the landing page from rails default to my index
  resources :events
end
