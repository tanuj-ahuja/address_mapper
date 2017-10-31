Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
   post   '/submit',   to: 'users#submit'
   post   '/confirm',    to: 'users#confirm'
end
