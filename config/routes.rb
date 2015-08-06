Rails.application.routes.draw do
  devise_for :users,  controllers: {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations', unlocks: 'users/unlocks'}
  
  root to: 'dashboard#main'

  get '/dashboard' => 'dashboard#main'
  get '/participants' => 'dashboard#participants'
  resources :surveys, only: [:create, :new, :edit, :update]
  namespace :api do
    
    
    get 'GetSurveyDetails', to: 'survey#survey_details'
    post 'RegisterParticipant', to: 'participants#create'
    
    resources :participant, only: [:create]

  end
end
