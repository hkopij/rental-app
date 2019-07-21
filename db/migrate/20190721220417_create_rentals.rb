class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :car, index: true
      t.datetime :rented_from
      t.datetime :rented_to
      t.timestamps
    end
  end
end
