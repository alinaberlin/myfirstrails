Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users
  resources :products
  resources :orders, only: [:index, :show, :create, :destroy]
  
  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'
  root 'static_pages#landing_page' 
  post 'static_pages/thank_you'

end
