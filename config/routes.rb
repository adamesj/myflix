Rails.application.routes.draw do
  match '/ui(/:action)', controller: 'ui', via: :get

  root 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
