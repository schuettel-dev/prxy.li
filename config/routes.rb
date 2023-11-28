Rails.application.routes.draw do
  root to: "links#index"
  resource :sessions, only: %i[new create destroy]
  resources :links, only: %i[index new create destroy]
  get ":token", to: "redirects#new", as: :redirect
end
