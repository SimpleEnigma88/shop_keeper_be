Rails.application.routes.draw do
  get 'sessions/create'
  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :players, only: %i[index show create update destroy] do
    resources :characters, only: %i[index show create update destroy]
    resources :parties, only: %i[index create show update destroy]
  end

  resources :characters do
    resources :character_magic_items, only: %i[create destroy index show]
    resources :parties, only: %i[index show]
  end

  # for managing magic items independently
  resources :magic_items, only: %i[index show create update destroy]
end
