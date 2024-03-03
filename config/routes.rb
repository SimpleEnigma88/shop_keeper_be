Rails.application.routes.draw do
  resources :players, only: [:index, :show, :create, :update, :destroy] do
    resources :characters, only: [:index, :show, :create, :update, :destroy]
    resources :parties, only: [:index, :create, :show, :update, :destroy]
  end

  resources :characters do
    resources :character_magic_items, only: [:create, :destroy, :index, :show]
    resources :parties, only: [:index, :show]
  end
  
  # for managing magic items independently
  resources :magic_items, only: [:index, :show, :create, :update, :destroy]
end