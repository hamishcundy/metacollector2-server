Rails.application.routes.draw do
  devise_for :users
  

  namespace :api do
    resources :paticipants
    get 'testCall', to: 'participants#test'
  end
end
