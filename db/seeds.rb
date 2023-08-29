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

User.create( email: "cianci.dylan@gmail.com", password: "1234567", password_confirmation: "1234567")

puts "Creating pokemons..."

pokemon_data = [
  {
    name: "Pikachu",
    description: "Un petit Pokémon électrique avec des joues rouges.",
    pokemon_type: "Électrique",
    location: "Forêt de Jade",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/025.png"
  },
  {
    name: "Bulbizarre",
    description: "Un Pokémon plante avec une plante sur son dos.",
    pokemon_type: "Plante",
    location: "Parc Safari",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png"
  },
  # ... Ajoutez les autres entrées de la liste de Pokémon ici ...
]

# Find or create the user with the specified email
userTest = User.find_or_create_by(email: "cianci.dylan@gmail.com")

# Create Pokémon records with associated images and user
pokemon_data.each do |data|
  file = URI.open(data[:image_url])
  pokemon = Pokemon.new(
    name: data[:name],
    description: data[:description],
    pokemon_type: data[:pokemon_type],
    location: data[:location],
    user: userTest
  )
  pokemon.images.attach(io: file, filename: "pokemon_image.png", content_type: "image/png")
  pokemon.save
end

puts "Finished! 10 users and 30 pokemons created!"
