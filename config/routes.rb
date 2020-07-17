Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      put 'approve'
      put 'deny'
    end
  end
end
