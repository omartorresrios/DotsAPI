Rails.application.routes.draw do

  scope 'settings' do
    get 'profile', to: 'settings#profile', as: 'settings_settings'
    patch 'profile', to: 'settings#update_profile', as: 'account_settings_update'
    # Avatar
    get 'avatar', to: 'settings#avatar', as: 'account_settings_avatar'
    patch 'avatar', to: 'settings#update_avatar', as: 'account_settings_avatar_update'
  end

  # Search
  get 'search', to: 'search#search', as: 'search_search'
  post 'search', to: 'search#do_search', as: 'search_do_search'

  # Users profile
  post ':username/ask', to: 'profile#ask', as: 'profile_ask'
  get ':username', to: 'profile#reviews', as: 'profile_reviews'

  root 'home#home'


  scope '/api' do
    namespace :users do
      post 'signup' => 'registrations#create'
    end
  end

end
