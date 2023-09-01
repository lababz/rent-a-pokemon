class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  # Crée une nouvelle review pour un booking
  def create
    @booking = Booking.find(params[:booking_id])
    @pokemon = @booking.pokemon
    @review = @booking.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @booking, notice: 'Review was successfully created.'
    else
      redirect_to @booking, alert: 'Review could not be created.'
    end
  end

  private

  # Définit les paramètres autorisés pour la review
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
