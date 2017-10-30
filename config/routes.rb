Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, :controllers => { :registrations => "my_registrations" }
  resources :users 
  resources :products do
  	resources :comments
  end
  resources :orders, only: [:index, :show, :create, :destroy]
  # mount ActionCable.server => '/cable'
  mount ActionCable.server => '/cable'
  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'
  root 'static_pages#landing_page' 
  post 'static_pages/thank_you'
  post 'payment/create'

  
end

