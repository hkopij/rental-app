# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :phone_number
      t.string :password_digest
      t.string :type, null: false

      t.timestamps
    end
  end
end
