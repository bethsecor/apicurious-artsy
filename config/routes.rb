Rails.application.routes.draw do
  root 'home#show'
  get  '/feed', to: 'feed#show'
  get  '/profile', to: 'profile#show'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
