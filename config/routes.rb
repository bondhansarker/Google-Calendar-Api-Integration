Rails.application.routes.draw do
  devise_for :users,controllers: { omniauth_callbacks: 'omniauth'}
  root 'appointments#index'
  resources :appointments do
    collection do
      get :google_calendar
    end
  end

  get 'google_calendar/redirect', to: 'google_calendar#redirect', as: 'google_calendar_redirect'
  get 'google_calendar/callback', to: 'google_calendar#callback', as: 'google_calendar_callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
