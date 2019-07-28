# frozen_string_literal: true

class UserRentalCreationRights
  attr_accessor :user_params

  def initialize(user_params)
    @user = user_params
  end

  def is_current_user_owner_of_a_rental?
    if @user.can_create_rentals?
      true
    else
      false
    end
  end
end
