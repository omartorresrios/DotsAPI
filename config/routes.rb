Rails.application.routes.draw do

  scope 'settings' do
    get 'profile' => 'settings#profile', as: 'settings_settings'
    patch 'profile' => 'settings#update_profile', as: 'account_settings_update'
    # Avatar
    get 'avatar' => 'settings#avatar', as: 'account_settings_avatar'
    patch 'avatar' => 'settings#update_avatar', as: 'account_settings_avatar_update'
  end

  # Search
  get 'search' => 'search#search', as: 'search_search'
  post 'search' => 'search#do_search', as: 'search_do_search'

  # Users profile
  post ':username/write' => 'profile#write', as: 'profile_write'
  get ':username' => 'profile#reviews', as: 'profile_reviews'

  root 'home#home'


  scope '/api' do

    get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get 'auth/:provider/callback', to: 'sessions#create'

    namespace :users do
      post 'signup' => 'registrations#create'
      post 'signin' => 'sessions#create'
      #post 'facebook/login' => 'facebook_logins#create'
      post 'google/login' => 'google_logins#create'
    end

    # patch ':username/avatar' => 'avatar_images#update'

    # Current user
    get 'reviews' => 'users#reviews'
    get 'events' => 'users#events'

    # Public profile (other users)
    get ':fullname/public_profile' => 'profile#show'
    post ':id/speak' => 'profile#speak'
    get ':id/events' => 'profile#events'
    get ':id/reviews' => 'profile#reviews'

    get 'all_users' => 'search#index'
    # get 'search' => 'search#search'
    # post 'search' => 'search#do_search'

    get 'all_reviews' => 'home#index'

    # Events
    post 'writeEvent' => 'event#create'
    get 'all_events' => 'event#index'
    
    # Avatar
    get 'avatar' => 'settings#avatar'
    patch 'avatar' => 'settings#update_avatar'

  end

end