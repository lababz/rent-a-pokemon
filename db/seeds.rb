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
  {
    name: "Salamèche",
    description: "Un lézard de feu avec une flamme à la queue.",
    pokemon_type: "Feu",
    location: "Mont Sélénite",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/004.png"
  },
  {
    name: "Carapuce",
    description: "Un Pokémon eau avec une carapace dure.",
    pokemon_type: "Eau",
    location: "Lac Colère",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png"
  },
  {
    name: "Mewtwo",
    description: "Un Pokémon légendaire créé en laboratoire.",
    pokemon_type: "Psy",
    location: "Grotte Azurée",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/150.png"
  },
  {
    name: "Dracaufeu",
    description: "Un dragon de feu qui vole dans le ciel.",
    pokemon_type: "Feu/Vol",
    location: "Route Victoire",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/006.png"
  },
  {
    name: "Mew",
    description: "Un Pokémon légendaire mystérieux aux pouvoirs variés.",
    pokemon_type: "Psy",
    location: "Glaziovie",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/151.png"
  },
  {
    name: "Raichu",
    description: "L'évolution de Pikachu, avec des pouvoirs électriques accrus.",
    pokemon_type: "Électrique",
    location: "Parc des Amis",
    image_url: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/026.png"
  }

]

# Création d'un utilisateur pour tester la génération de pokemons, ne pas oublié de faire pour Hadrien et Michel
userTest = User.find_or_create_by(email: "cianci.dylan@gmail.com")

# Create Pokémon records with associated images and user
pokemon_data.each do |data|
  file = URI.open(data[:image_url])
  pokemon = Pokemon.new(
    name: data[:name],
    description: data[:description],
    pokemon_type: data[:pokemon_type],
    location: data[:location],
    price: rand(1..100),
    user: userTest
  )
  pokemon.images.attach(io: file, filename: "pokemon_image.png", content_type: "image/png")
  pokemon.save
end

puts "Finished! 10 users and 30 pokemons created!"
