Personal::Application.routes.draw do

  devise_for :admins# Bug: skip: registration isn't allowing me to log in; investigate with version 1.0 of this site. All done inside an entirely different thing.

 

  concern :goalable do
    resources :goals, only: [:new, :create, :edit, :update]
  end
  
  resources :skills, controller: :technologies
  resources :technologies#, only: [:index, :update, :edit, :create, :new, :destroy]

  root 'high_voltage/pages#show', id: 'home'


  resources :projects, concerns: :goalable do 
    resources :identity_guidelines
    resources :photos, only: [:show, :new, :edit, :update, :destroy, :create]
    resources :clients 
    resources :attachments, only: [:new, :update, :destroy, :create]
    #resources :goals, only: [:new, :create, :edit, :update]
    resources :technology_profiles, only: [:new, :edit, :update, :destroy, :create] 
    resources :personas do 
      resources :influencers
      #resources :goals, only: [:new, :create, :edit, :update]
      resources :interests, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :personas, concerns: :goalable, only: [:show, :new, :create, :edit, :update, :destroy]

  resources :clients, concerns: :goalable, only: [:index, :show]


end
