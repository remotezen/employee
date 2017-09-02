Rails.application.routes.draw do

  get 'employee/:id', to: 'employees#show', as: 'employee'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :events
  resources  :offs
  root to:  'events#index' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise routes
end
#/home/remotezen/.rbenv/versions/2.4.1/bin/wkhtmltopdf
