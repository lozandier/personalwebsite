Personal::Application.routes.draw do

  devise_for :admins
  concern :goalable do
    resources :goals, only: [:new, :create, :edit, :update]
  end

  resources :technologies, only: [:index, :update, :edit, :create, :new, :destroy]

  root 'projects#index'

  resources :projects, concerns: :goalable do 
    resources :identity_guidelines
    resources :photos, only: [:show, :new, :edit, :update, :destroy, :create]
    resources :clients 
    resources :attachments, only: [:new, :update, :destroy, :create]
    resources :goals, only: [:new, :create, :edit, :update]
    resources :technology_profiles, only: [:new, :edit, :update, :destroy, :create] 
    resources :personas do 
      resources :influencers
      #resources :goals, only: [:new, :create, :edit, :update]
      resources :interests, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :personas, concerns: :goalable, only: [:show, :new, :create, :edit, :update]

  resources :clients, concerns: :goalable, only: [:index, :show]


end
