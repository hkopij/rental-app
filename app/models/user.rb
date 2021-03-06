# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  def can_create_rentals?
    type == 'Owner'
  end
end
