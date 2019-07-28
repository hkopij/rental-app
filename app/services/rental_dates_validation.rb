# frozen_string_literal: true

class RentalDatesValidation
  attr_accessor :rental_params

  def initialize(rental_params)
    @rental = rental_params
  end

  def rental_available?
    if @rental.list_of_colliding_rentals.empty?
      true
    else
      false
    end
  end
end
