CuberootLts::Application.routes.draw do
  get "holidays/index"

  devise_for :users

  resources :leaves do
    member do
      get 'approve_reject'
    end
  end


  resources :users do
    member do
      get 'user_management'
    end
  end

  resources :setups

  resources :holidays


root :to => "home#index"

end
