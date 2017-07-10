Rails.application.routes.draw do
  devise_for :users
  match '/ui(/:action)', controller: 'ui', via: :get

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
  get 'my_queue', to: 'queue_items#index'

  resources :categories, only: [:show]

  resources :queue_items, only: [:create]

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
end
