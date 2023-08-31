class Review < ApplicationRecord
  # associations
  belongs_to :booking
  belongs_to :user

  # validations
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { minimum: 10 }
end
