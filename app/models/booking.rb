class Booking < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :pokemon
  has_many :reviews, dependent: :destroy

  # validations
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true, numericality: { only_integer: false, greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date?

  private

  def end_date_after_start_date?
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "End date must be after start date")
    end
  end
end
