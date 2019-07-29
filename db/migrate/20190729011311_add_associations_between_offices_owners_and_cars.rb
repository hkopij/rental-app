class AddAssociationsBetweenOfficesOwnersAndCars < ActiveRecord::Migration[5.2]
  def change
    add_reference :offices, :owner, index: true
    add_reference :cars, :office, index: true
  end
end
