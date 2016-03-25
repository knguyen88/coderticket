Rails.application.routes.draw do
  root 'events#index'

  resources :events do
    resources :tickets
    collection do
      get 'my_events', to: 'events#my_events'
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
