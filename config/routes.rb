Rails.application.routes.draw do
  root to: 'links#index'
  resources :links, only: %i[new create destroy]
  get ':token', to: 'redirects#new', as: :redirect
end
