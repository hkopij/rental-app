class CreateCar < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :make
      t.string :year
      t.integer :mileage
      t.string :condition
      t.belongs_to :office, index: true

      t.timestamps
    end
  end
end
