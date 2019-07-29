# frozen_string_literal: true

class CarOwnership
  attr_accessor :user_params, :rental_params

  def initialize(user_params, rental_params)
    @user = user_params
    @rental = rental_params
  end

  def car_belongs_to_user?
    @user.office == @rental.car.office
  end
end
