Rails.application.routes.draw do
  devise_for :users
  match '/ui(/:action)', controller: 'ui', via: :get

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
