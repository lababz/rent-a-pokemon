class PagesController < ApplicationController
  # Affiche la page d'accueil avec la liste des Pokémon
  def home
    @pokemons = Pokemon.all
    if params[:pokemon_type].present?
      @pokemons = @pokemons.where(pokemon_type: params[:pokemon_type])
    end
  end
end
