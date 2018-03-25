Rails.application.routes.draw do
  resources :companies, only: [:index] do
    collection do
      get :alphabetically
    end
  end
end
