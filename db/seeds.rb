# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
require "open-uri"

puts "Cleaning database..."
User.destroy_all
Pokemon.destroy_all

puts "Creating users..."

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

puts "Creating pokemons..."

pokemon_types = [
  "Normal", "Fire", "Water", "Grass", "Electric", "Ice", "Fighting",
  "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost",
  "Dragon", "Dark", "Steel", "Fairy"
]

file1 = URI.open("https://oyster.ignimgs.com/mediawiki/apis.ign.com/pokemon-blue-version/8/89/Pikachu.jpg")

10.times do
  pokemon = Pokemon.new(
    name: Faker::Games::Pokemon.name,
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
    pokemon_type: pokemon_types.sample,
    location: Faker::Address.full_address,
    user: User.all.sample
  )
  pokemon.photo.attach(io: file1, filename: "Pokem.png", content_type: "image/png")
  pokemon.save
end

puts "Finished! 10 users and 30 pokemons created!"
