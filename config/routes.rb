Rails.application.routes.draw do
  resources :menus do
    member do
      patch :toggle_favourite  # This will be used to toggle the favourite status
    end
  end

  get 'meal_plans/edit/:week', to: 'meal_plans#edit', as: 'edit_meal_plan'
  resources :meal_plans, only: [:index, :create, :edit, :update]
  
  resources :grocery_lists, only: [:index] do
    collection do
      patch 'update', to: 'grocery_lists#update', as: 'update'
      get 'view_list', to: 'grocery_lists#view_list'
    end
  end

  root 'meal_plans#index'
end
