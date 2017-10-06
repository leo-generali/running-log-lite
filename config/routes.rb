Rails.application.routes.draw do
  resources :activities
  root 'pages#home'
  get '/races', to: 'pages#races', as: :races
  get 'date/:date', to: 'pages#activities_in_date', as: :activities_in_date
end
