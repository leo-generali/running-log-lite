Rails.application.routes.draw do
  resources :activities
  root 'pages#home'
  get 'date/:date', to: 'pages#activities_in_date', as: :activities_in_date # (with location being national)
end
