Rails.application.routes.draw do
  resources :vagas do
    post :reservar, to: 'reservas#reservar'
  end

  root 'vagas#index'
end
