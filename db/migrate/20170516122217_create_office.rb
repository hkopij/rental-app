class CreateOffice < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :street
      t.string :postal_code
      t.string :city
      t.string :phone_number
      t.belongs_to :owner, index: true

      t.timestamps
    end
  end
end
