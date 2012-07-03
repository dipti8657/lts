CuberootLts::Application.routes.draw do
  get "holidays/index"

  devise_for :users, :controllers => {:sessions => "sessions"}


  resources :leaves do
    member do
      get 'approve_reject', 'change_year', 'reject_approved_leaves'
    end
    collection do
      post 'set_year'
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
