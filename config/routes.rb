Rails.application.routes.draw do
  devise_for :users
  

  namespace :api do
    
    get 'testCall', to: 'participants#test'
    get 'GetSurveyDetails', to: 'survey#survey_details'
    post 'RegisterParticipant', to: 'participants#create'

  end
end
