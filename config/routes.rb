Rails.application.routes.draw do
  devise_for :users,  controllers: {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations', unlocks: 'users/unlocks'}
  
  root to: 'dashboard#main'

  get '/dashboard' => 'dashboard#main'
  resources :participants, only: [:index, :destroy] do
    member do
      get '/summary' => 'participants#summary'
      get '/data' => 'participants#data'
      get '/timeline' => 'participants#timeline'
      get '/timeline_data' => 'participants#timeline_data', :defaults => { :format => 'json'}
      get '/analysis' => 'participants#analysis'
      get '/map' => 'participants#map'
      post '/generateTimeline' => 'participants#generate_timeline'
    end
  end

  
  resources :surveys, only: [:create, :new, :edit, :update]

  namespace :api do
    
    
    get 'GetSurveyDetails', to: 'survey#survey_details'
    post 'RegisterParticipant', to: 'participants#create'
    post 'UploadMetadata', to: 'data#upload'
    post 'LocationUpdate', to: 'data#location'
    
    resources :participant, only: [:create]

  end
end
