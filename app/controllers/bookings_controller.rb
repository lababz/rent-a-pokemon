class BookingsController < ApplicationController
  # Affiche toutes les réservations de l'utilisateur connecté
  def index
    @bookings = current_user.bookings
  end

  # Affiche le formulaire de réservation pour un nouveau Pokémon
  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = @pokemon.bookings.build
  en
  end

  # Crée une nouvelle réservation pour un Pokémon
  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = @pokemon.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to @pokemon, notice: 'Booking was successfully created.'
    else
      render :new, alert: 'Booking could not be created.'
    end
  end

  # Supprime une réservation
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to root_path, notice: 'Booking was successfully destroyed.'
  end

  private

  # Définit les paramètres autorisés pour la réservation
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price)
  end
end