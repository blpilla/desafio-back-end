Rails.application.routes.draw do
  resources :cnabs
  root to: 'cnabs#index'
  post '/cnabs/:id', to: 'cnabs#store'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
