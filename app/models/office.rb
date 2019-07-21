# frozen_string_literal: true

class Office < ApplicationRecord
  belongs_to :owner
  has_many :cars
end
