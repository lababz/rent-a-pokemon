class ReviewsController < ApplicationController
  # Crée une nouvelle review pour un booking
  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = Booking.find(params[:booking_id]) # TODO: checek s'il y a bien un paramètre pour l'ID du booking
    @review = @booking.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @booking, notice: 'Review was successfully created.'
    else
      render @booking, alert: 'Review could not be created.'
    end
  end

  private

  # Définit les paramètres autorisés pour la review
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
