Rails.application.routes.draw do
  resources :lessons
  resources :courses do
    member do
      patch :generate_lessons
    end
  end
  resources :services
  resources :classrooms
  devise_for :users, controllers: { 
    confirmations: 'confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show, :destroy, :edit, :update, :destroy] do
    member do
      patch :ban
      patch :resend_confirmation_instructions
      patch :resend_invitation
    end
  end
  root 'static_pages#landing_page'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'calender', to: 'static_pages#calender'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
