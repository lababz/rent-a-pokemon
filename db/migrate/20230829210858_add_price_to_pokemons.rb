class AddPriceToPokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :price, :decimal
  end
end
