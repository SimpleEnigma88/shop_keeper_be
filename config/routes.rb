Rails.application.routes.draw do
  resources :players, only: [:index, :show, :create, :update, :destroy] do
    resources :characters, only: [:index, :show, :create, :update, :destroy]
  end

  resources :characters do
    resources :magic_items, only: [:index, :show, :destroy] # for assigning existing items
  end

  resources :magic_items, only: [:index, :show, :create, :update, :destroy] # for managing magic items independently
end