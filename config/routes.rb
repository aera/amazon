Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get('/', {to: 'welcome#index', as: 'home'})
  get('/about', {to: 'welcome#about'})

  get('/contact', {to: 'contact#new'})
  post('/contact', {to: 'contact#create'})

  #resources :products do
  #  resources :reviews
  #end
  #resources :favourites, only: [:create, :destroy]



  resources :products, shallow: true do
    resources :favourites, only: [:create, :destroy]
    resources :reviews do
      resources :likes
    end
  end

  resources :reviews, only: [], shallow: true do
    resources :votes, only: [:create, :destroy, :update]
  end


  resources :tags, only: [:index, :show]

  resources :reviews do
    resources :likes
  end


  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :admin do
    resources :dashboard, only: [:index]
  end
end
