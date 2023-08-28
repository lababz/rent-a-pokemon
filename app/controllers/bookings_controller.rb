class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = @pokemon.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to @pokemon, notice: 'Booking was successfully created.'
    else
      render @pokemon, alert: 'Booking could not be created.'
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to root_path, notice: 'Booking was successfully destroyed.'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price)
  end
end
