Rails.application.routes.draw do
  match '/ui(/:action)', controller: 'ui', via: :get
end
