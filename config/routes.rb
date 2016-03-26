Rails.application.routes.draw do
  root 'events#index'

  resources :events, :except => [:destroy] do
    resources :tickets, :except => [:destroy, :update]do
      collection do
        post 'buy', to: 'tickets#buy'
      end
    end
    collection do
      get 'my_events', to: 'events#my_events'
      post ':id', to: 'events#update'
      post ':id/publish', to: 'events#publish', as: :publish_event
    end
  end

  get '/login', to: 'users#show_login_form'
  post '/login', to: 'users#do_login'

  post '/logout', to: 'users#do_logout'

  get '/register', to: 'users#show_register_form'
  post '/register', to: 'users#do_create_user'

  get '/venues', to: 'venues#show_venues_list'
  get '/venues/new', to: 'venues#show_new_venue_form', as: :new_venue
  post '/venues/new', to: 'venues#create_new_venue'
end
