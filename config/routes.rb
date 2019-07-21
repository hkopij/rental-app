Rails.application.routes.draw do
  mount Knock::Engine => '/auth'
  resources :rentals, only: %i[create index]
end
