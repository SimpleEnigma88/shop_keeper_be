Rails.application.routes.draw do
  resources :players, only: [:index, :show, :create, :update, :destroy] do
    resources :characters, only: [:index, :show, :create, :update, :destroy]
      resources :magic_items, only: [:index, :show, :create, :update, :destroy]
  end
end
