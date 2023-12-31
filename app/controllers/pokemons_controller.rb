class PokemonsController < ApplicationController
  # # Affiche la liste des Pokémon
  def index
    @pokemons = Pokemon.where(user: current_user)
  end

  # Affiche les détails d'un Pokémon
  def show
    @pokemon = Pokemon.find(params[:id])
    @bookings = Booking.where(pokemon_id: params[:id])
    @reviews = Review.where(booking_id: @bookings.ids)
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
      redirect_to @pokemon
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    redirect_to pokemons_path
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def update
    @pokemon = Pokemon.find(params[:id])

    if params[:pokemon][:images].present?
      # @pokemon.images.purge  # Supprime l'image existante (Active Storage)
      @pokemon.images.attach(params[:pokemon][:images])  # Attache le nouveau fichier
    end

    if @pokemon.update(pokemon_update_params)
      redirect_to @pokemon
    else
      render :edit
    end
  end

  private

  # Définit les paramètres autorisés pour le Pokémon
  def pokemon_params
    params.require(:pokemon).permit(:name, :description, :pokemon_type, :location, :price, images: [])
  end

  def pokemon_update_params
    params.require(:pokemon).permit(:name, :description, :pokemon_type, :location, :price)
  end
end
