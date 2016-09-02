Rails.application.routes.draw do
  get '/search', to: 'search#autocomplete'
  get '/cards/:id', to: 'cards#show'
  get '/sets/:id', to: 'sets#show'

  root to: 'pages#index'
end
