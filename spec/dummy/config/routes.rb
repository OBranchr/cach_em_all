Dummy::Application.routes.draw do  
  resources :arbitrary_records
  root 'arbitrary_records#index'
end
