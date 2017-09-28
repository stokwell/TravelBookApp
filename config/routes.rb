Rails.application.routes.draw do

  root to: "trips#index"
  resources :trips

  get 'last-trips', to: 'trips#last_trips'
  get 'overview', to: 'trips#months'
end
