class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.text :description
      t.string :pokemon_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
