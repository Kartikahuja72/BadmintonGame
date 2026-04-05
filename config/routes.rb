Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  root "pages#login"

  get "/login", to: "pages#login"
  get "/signup", to: "pages#signup"
  get "/dashboard", to: "pages#dashboard"
  get "/players-page", to: "pages#players"
  get "/players/new", to: "pages#new_player"
  get "/players/:id/edit", to: "pages#edit_player"
  get "/matches-page", to: "pages#matches"
  get "/leaderboard-page", to: "pages#leaderboard"
  get "/match-results-page", to: "pages#match_results"

  post '/signup', to: 'users#create'
  post '/login', to: 'authentication#authenticate'

  get "stats/leaderboard", to: "stats#leaderboard"
  get "/match_results", to: "stats#match_results"

  resources :players, only: [:index, :create, :update, :destroy]
  resources :matches, only: [:create]
end
