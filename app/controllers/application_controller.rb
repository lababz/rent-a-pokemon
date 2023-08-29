class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  # Définit l'utilisateur actuellement connecté
  def set_current_user
    @current_user = current_user
  end
end
