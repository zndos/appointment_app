# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :specialities, except: :show
  resources :doctors do
    resources :appointments, shallow: true
  end
  resource :patient, except: %i[new create show destroy]
end
