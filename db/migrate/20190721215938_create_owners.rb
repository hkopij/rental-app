# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners, &:timestamps
  end
end
