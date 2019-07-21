# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "jan#{n}@example.com" }
    first_name { 'Jan' }
    last_name { 'Kowalski' }
    street { 'Warszawska 1/1' }
    city { 'Warszawa' }
    postal_code { '00-173' }
    phone_number { '123456789' }
    password { 'password123' }
    type { 'Customer' }
  end

  factory :owner do
    sequence(:email) { |n| "jan#{n}@example.com" }
    first_name { 'Jan' }
    last_name { 'Kowalski' }
    street { 'Warszawska 1/1' }
    city { 'Warszawa' }
    postal_code { '00-173' }
    phone_number { '123456789' }
    password { 'password123' }
    type { 'Owner' }
  end

  factory :office do
    owner
    street { 'Warszawska 1/1' }
    postal_code { '00-173' }
    city { 'Warszawa' }
    phone_number { '123456789' }
  end

  factory :car do
    office
    model { 'Honda' }
    make { 'Make' }
    year { '2000' }
    mileage { '120000' }
    condition { 'Awesome' }
  end

  factory :rental do
    customer
    car
    rented_from { '2019-07-29' }
    rented_to { '2019-07-30' }
  end
end
