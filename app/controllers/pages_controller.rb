class PagesController < ApplicationController
  # Affiche la page d'accueil avec la liste des Pokémon
  def home
    @pokemons = Pokemon.all
  end
end
