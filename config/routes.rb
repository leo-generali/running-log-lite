Rails.application.routes.draw do

  resources :activities
  root 'pages#home'

  get 'activities/:id', to: 'activities#show'

end
