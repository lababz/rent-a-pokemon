class PagesController < ApplicationController
  # On ne veut pas que l'utilisateur soit connecté pour accéder à la page d'accueil
  skip_before_action :authenticate_user!, only: [:home]
  # Affiche la page d'accueil avec la liste des Pokémon

  def home
    @pokemons = Pokemon.all
    if params[:pokemon_type].present?
      @pokemons = @pokemons.where(pokemon_type: params[:pokemon_type])
    end

    # The `geocoded` scope filters only pokemons with coordinates = > Same as: @markers = @pokemons.where(latitude: nil, longitude: nil)
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude
      }
    end
  end
end
