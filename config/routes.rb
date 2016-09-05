Rails.application.routes.draw do
  get '/search', to: 'search#autocomplete', as: 'autocomplete'
  get '/q', to: 'search#normal', as: 'search'

  get '/cards/:id', to: 'cards#show', as: 'card'
  get '/sets', to: 'sets#index'
  get '/sets/:id', to: 'sets#show', as: 'set'

  root to: 'pages#index'
end
