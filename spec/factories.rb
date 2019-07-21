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
    street { 'Warszawska 1/1' }
    postal_code { '00-173' }
    city { 'Warszawa' }
    phone_number { '123456789' }
  end

  factory :car do
    model { 'Honda' }
    make { 'Make' }
    year { '2000' }
    mileage { '120000' }
    condition { 'Awesome' }
  end

  factory :rental do
    customer
    car
  end
end
