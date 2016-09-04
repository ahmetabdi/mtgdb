Rails.application.routes.draw do
  get '/search', to: 'search#autocomplete'
  get '/cards/:id', to: 'cards#show', as: 'card'
  get '/sets', to: 'sets#index'
  get '/sets/:id', to: 'sets#show', as: 'set'

  root to: 'pages#index'
end
