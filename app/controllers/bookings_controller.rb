class BookingsController < ApplicationController
  # Affiche toutes les réservations de l'utilisateur connecté
  def index
    @bookings = current_user.bookings
    @reviews = Review.where(params[:booking_id])
  end

  # Affiche le formulaire de réservation pour un nouveau Pokémon
  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = @pokemon.bookings.build
    @marker = [
      {
        lat: @pokemon.latitude,
        lng: @pokemon.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {pokemon: @pokemon}),
        marker_html: render_to_string(partial: "marker")
      }
    ]
  end

  def show
    @booking = Booking.find(params[:id])
    @pokemon = @booking.pokemon
    @review = Review.new(booking: @booking)
    @marker = [
      {
        lat: @pokemon.latitude,
        lng: @pokemon.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {pokemon: @pokemon}),
        marker_html: render_to_string(partial: "marker")
      }
    ]
  end

  # Crée une nouvelle réservation pour un Pokémon
  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = @pokemon.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: 'Ton Pokémon a bien été réservé !'
    else
      render :new, alert: "La réservation n'a pas pu être créée. Veuillez réessayer et si le pronblème persiste, contactez-nous."
    end
  end

  # Supprime une réservation
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Réservation annulée ! Nous prévenons le dresseur.'
  end

  private

  # Définit les paramètres autorisés pour la réservation
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price)
  end
end
