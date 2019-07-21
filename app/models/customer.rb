class Customer < ApplicationRecord
  has_many :rentals
  has_many :cars, through: :rentals
end
