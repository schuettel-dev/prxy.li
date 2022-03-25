Rails.application.routes.draw do
  root to: 'links#new'
  resources :links, only: %i[index new create destroy]
  get ':token', to: 'redirects#new', as: :redirect
end
