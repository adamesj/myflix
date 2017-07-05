Rails.application.routes.draw do
  match '/ui(/:action)', controller: 'ui', via: :get
  root 'videos#index'
  resources :videos
end
