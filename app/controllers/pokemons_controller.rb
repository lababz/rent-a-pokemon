class PokemonsController < ApplicationController
  # # Affiche la liste des Pokémon
  # def index
  #     @pokemons = Pokemon.all
  # end

  # Affiche les détails d'un Pokémon
  def show
    @pokemon = Pokemon.find(params[:id])
  end

  # Affiche le formulaire de création d'un nouveau Pokémon
  def new
    @pokemon = Pokemon.new
  end

  # Crée un nouveau Pokémon
  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if @pokemon.save
      redirect_to @pokemon, notice: 'Pokemon was successfully created.'
    else
      render :new
    end
  end

  private

  # Définit les paramètres autorisés pour le Pokémon
  def pokemon_params
    params.require(:pokemon).permit(:name, :description, :pokemon_type, :location, images: [])
  end
end
