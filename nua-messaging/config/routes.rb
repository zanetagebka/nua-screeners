Rails.application.routes.draw do

  root to: 'messages#index'

  resources :messages, only: %w[index show new create] do
    member do
      post :resend_prescription
    end
  end

end
