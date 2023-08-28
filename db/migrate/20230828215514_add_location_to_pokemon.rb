class AddLocationToPokemon < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :location, :string
  end
end
