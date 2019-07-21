# frozen_string_literal: true

class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car

  validates :customer, presence: true
  validates :car, presence: true
  validates :rented_from, presence: true, date: { after_or_equal_to: Time.now }
  validates :rented_to, presence: true, date: { after_or_equal_to: :rented_from }
end
