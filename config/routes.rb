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
  post ':username/write' => 'profile#write', as: 'profile_wirte'
  get ':username' => 'profile#reviews', as: 'profile_reviews'

  root 'home#home'


  scope '/api' do
    namespace :users do
      post 'signup' => 'registrations#create'
      post 'signin' => 'sessions#create'
      # post 'facebook/login' => 'facebook_logins#create'
    end

    # patch ':username/avatar' => 'avatar_images#update'

    get ':username/public_profile' => 'profile#show'
    get ':username/reviews' => 'profile#reviews'
    post ':username/write' => 'profile#write'

    get 'search' => 'search#search'
    post 'search' => 'search#do_search'

  end

end
