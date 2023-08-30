class Pokemon < ApplicationRecord
  # associations
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy
  has_many_attached :images

  # validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :pokemon_type, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { only_integer: false, greater_than: 0 }

  TYPES = ['Normal', 'Feu', 'Eau', 'Plante', 'Electrique', 'Glace', 'Combat', 'Poison', 'Sol', 'Vol', 'Psy', 'Insecte', 'Roche', 'Spectre', 'Ténèbres', 'Acier', 'Fée']
end
