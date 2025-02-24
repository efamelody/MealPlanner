Rails.application.routes.draw do
  resources :menus # This will generate all routes, including `new`, `edit`, `create`, `update`, `destroy`
  resources :meal_plans, only: [:index, :create, :update]
  resources :grocery_lists, only: [:index, :update]

  root 'menus#index'
end
