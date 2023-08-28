class PagesController < ApplicationController
  def home
    redirect_to pokemons_path
  end
end
