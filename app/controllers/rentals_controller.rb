# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authenticate
  before_action :set_rental, only: :create

  def index
    @rentals = Rental.all
  end

  def create
    if current_user.can_create_rentals?
      # this method validates if logged user is owner of office that we want to
      # create rental in, if so it validates if provided dates are available for
      # new rental. If both validations passes - it creates new rental
      validate_ownership_and_availiblity
    else
      render json: 'You are not allowed to create rental'.to_json,
             status: :unprocessable_entity
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:car_id,
                                   :customer_id,
                                   :rented_from,
                                   :rented_to)
  end

  def set_rental
    @rental = Rental.new(rental_params)
  end

  def validate_ownership_and_availiblity
    if current_user.office == @rental.car.office
      validate_availiblity
    else
      render json: 'The car must belong to your office!'.to_json,
             status: :unprocessable_entity
    end
  end

  def validate_availiblity
    rentals = @rental.car.rentals.all
    # case #1, car is rented inside of requested period
    rentals_1 = rentals.where('rented_from <= ? AND rented_to >= ?',
                                        @rental.rented_from, @rental.rented_to)
    # case #2, car is rented at the beginning of requested period
    rentals_2 = rentals.where('rented_from > ? AND rented_to >= ? AND rented_from <= ?',
                                        @rental.rented_from, @rental.rented_to, @rental.rented_to)
    # case #3, car is rented at the end of requested period
    rentals_3 = rentals.where('rented_from <= ? AND rented_to <= ? AND rented_to > ?',
                                        @rental.rented_from, @rental.rented_to, @rental.rented_from)
    # case #4, car is rented for the whole time of requested period
    rentals_4 = rentals.where('rented_from > ? AND rented_to < ?',
                                        @rental.rented_from, @rental.rented_to)

    rentals = rentals_1 + rentals_2 + rentals_3 + rentals_4

    if rentals.empty?
      @rental.save
      render json: @rental
    else
      render json: 'The car is already rented to someone else!'.to_json,
             status: :unprocessable_entity
    end
  end
end
