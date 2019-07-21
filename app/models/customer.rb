class Customer < User
  has_many :rentals
  has_many :cars, through: :rentals
end
