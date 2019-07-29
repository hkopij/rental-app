# frozen_string_literal: true

class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car

  validates :customer, presence: true
  validates :car, presence: true
  validates :rented_from, presence: true, date: true
  validates :rented_to, presence: true, date: { after_or_equal_to: :rented_from }

  def list_of_colliding_rentals
    rentals = car.rentals.all
    rentals = rentals.where.not('rented_from > ? OR rented_to < ?',
                                rented_to, rented_from)
  end
end
