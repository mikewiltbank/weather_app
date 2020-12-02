Rails.application.routes.draw do

  root 'weather_locations#index'

  resources :weather_locations, only: [:index, :show, :create, :update, :destroy] do
    collection do
      put :update_all
    end
  end

end
