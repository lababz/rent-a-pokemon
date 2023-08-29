Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"  # Redirection vers la page d'accueil

  # # Routes pour la navigation
  # get '/connexion', to: 'sessions#new'
  # post '/connexion', to: 'sessions#create'
  # delete '/deconnexion', to: 'sessions#destroy'

  # Routes pour la gestion des pokémons (appartements)
  resources :pokemons, only: [:index, :show, :new, :create]

  # Routes pour la gestion des réservations
  resources :bookings, only: [:index, :create, :destroy]

  # Routes pour la gestion des avis
  resources :pokemons, only: [] do
    resources :reviews, only: [:create]
  end

  # Routes pour la gestion des photos
  resources :photos, only: [:create, :destroy]

  # # Route pour la localisation des appartements sur une carte
  # get '/localisation', to: 'pokemons#map'

  # # Routes pour la connexion avec Facebook
  # get '/auth/facebook', to: 'sessions#facebook'
  # get '/auth/facebook/callback', to: 'sessions#facebook_callback'

  # # Route pour envoyer une notification par e-mail
  # post '/notification', to: 'bookings#send_notification'

  # ... (autres routes nécessaires)
end
