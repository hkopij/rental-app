# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authenticate
  before_action :set_rental,
                :validate_user,
                :validate_car,
                :validate_rental_dates,
                only: :create

  def index
    @rentals = Rental.all
  end

  def create
    @rental.save
    render json: @rental
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

  def validate_user
    unless UserRentalCreationRights.new(current_user).is_current_user_owner_of_a_rental?
      render json: 'You are not allowed to create rental'.to_json,
             status: :unprocessable_entity
    end
  end

  def validate_car
    unless CarOwnership.new(current_user, @rental).car_belongs_to_user?
      render json: 'The car must belong to your office!'.to_json,
             status: :unprocessable_entity
    end
  end

  def validate_rental_dates
    unless RentalDatesValidation.new(@rental).rental_available?
      render json: 'The car is already rented to someone else!'.to_json,
             status: :unprocessable_entity
    end
  end
end
