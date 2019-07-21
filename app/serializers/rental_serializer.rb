class RentalSerializer < ActiveModel::Serializer
  attribute :customer_id
  attribute :car_id
  attribute :car_make
  attribute :car_model
  attribute :rented_from
  attribute :rented_to

  def car_make
    object.car.make
  end

  def car_model
    object.car.model
  end
end
