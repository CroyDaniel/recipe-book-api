Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games, only: [:index, :show]
  resources :ingredients, only: [:index]
  resources :recipes, only: [:index]
end
