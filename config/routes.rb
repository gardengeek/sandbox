Rails.application.routes.draw do
  resources :companies, only: [:index] do
    collection do
      get :alphabetically
      get :created_last_month
      get :not_trialing
      get :with_modern_plan
    end
  end
end
