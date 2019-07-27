# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authenticate
  before_action :set_rental,
                :validate_if_user_can_create_rentals,
                :validate_if_car_belongs_to_correct_office,
                :validate_if_rental_dates_arent_already_taken,
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

  def validate_if_user_can_create_rentals
    unless current_user.can_create_rentals?
      render json: 'You are not allowed to create rental'.to_json,
             status: :unprocessable_entity
    end
  end

  def validate_if_car_belongs_to_correct_office
    if current_user.office != @rental.car.office
      render json: 'The car must belong to your office!'.to_json,
             status: :unprocessable_entity
    end
  end

  def validate_if_rental_dates_arent_already_taken
    unless @rental.collision.empty?
      render json: 'The car is already rented to someone else!'.to_json,
             status: :unprocessable_entity
    end
  end
end
