namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard
  get '/subscribers', to: 'dashboard#subscribers', as: :subscribers
  get '/update_subscribers/:id', to: 'dashboard#update_subscribers', as: :update_subscribers
  get '/new_subscriber', to: 'dashboard#new_subscriber', as: :new_subscriber
  post '/subscribers', to: 'dashboard#create_subscribers', as: :create_subscribers
  post '/subscribers/send_msg', to: 'dashboard#send_msg', as: :send_msg
  delete '/remove_subscribers/:id', to: 'dashboard#remove_subscribers', as: :remove_subscribers

  get '/members', to: 'members#index'
  post '/complete', to: 'id_documents#complete' 
  post '/uncomplete', to: 'id_documents#uncomplete' 
  post '/complete', to: 'members#complete' 
  post '/uncomplete', to: 'members#uncomplete' 

  get "money/sent",               to: "money#money_sent",     as: "sent_money"
  get "money/requested",          to: "money#money_request",  as: "requested_money"
  post "money/resend_instructions/:id", to: "money#resend_instructions",   as: "resend_instructions_money"
  post "money_controller/manage/:id/:doaction", to: "money#manage",         as: "manage_money"

  #get '/categories', to: "dashboard#kicksmart_categories", as: "categories"

  namespace :kicksmart do 
    resources :categories
    resources :projects
  end
  

  resources :documents
  resources :id_documents,     only: [:index, :show, :update] do
    member do
      post :complete
      post :uncomplete
    end
  end
  resource  :currency_deposit, only: [:new, :create]
  resources :proofs
  resource  :sliders, only: [:edit, :update]
  resources :tickets, only: [:index, :show] do
    member do
      patch :close
    end
    resources :comments, only: [:create]
  end

  resources :members, only: [:index, :show, :update, :edit] do
    member do
      post :active
      post :toggle
      post :withdraw
      post :complete
      post :uncomplete
    end

    resources :two_factors, only: [:destroy]
  end

  namespace :deposits do
    Deposit.descendants.each do |d|
      resources d.resource_name
    end
  end

  namespace :withdraws do
    Withdraw.descendants.each do |w|
      resources w.resource_name
    end
  end

  namespace :statistic do
    resource :members, :only => :show
    resource :orders, :only => :show
    resource :trades, :only => :show
    resource :deposits, :only => :show
    resource :withdraws, :only => :show
  end
end
