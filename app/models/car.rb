# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :office
  has_many :rentals
  has_many :customers, through: :rentals

  validates :office, presence: true
end
