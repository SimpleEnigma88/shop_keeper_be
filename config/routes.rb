Rails.application.routes.draw do
  resources :players, only: [:index, :show, :create, :update, :destroy] do
    resources :characters, only: [:index, :show, :create, :update, :destroy]
  end

  resources :characters do
    resources :character_magic_items, only: [:create, :destroy]
  end

  resources :magic_items, only: [:index, :show, :create, :update, :destroy] # for managing magic items independently
end