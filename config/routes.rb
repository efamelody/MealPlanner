Rails.application.routes.draw do
  resources :menus
  resources :meal_plans, only: [:index, :create]
  
  resources :grocery_lists, only: [:index] do
    collection do
      patch 'update', to: 'grocery_lists#update', as: 'update'
      get 'view_list', to: 'grocery_lists#view_list'
    end
  end

  root 'meal_plans#index'
end
