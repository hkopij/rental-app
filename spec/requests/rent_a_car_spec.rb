# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'POST /office/:office_id/rentals', type: :request do
  let(:customer) { create :customer }
  let(:owner) { create :owner }
  let(:office) { create :office, owner: owner }
  let(:car) { create :car, office: office }
  let(:rented_from) { DateTime.now + 1.day }
  let(:rented_to) { DateTime.now + 8.days }

  let(:action) do
    post '/rentals', params: { rental: params }, headers: headers
  end

  let(:params) do
    {
      car_id: car.id,
      customer_id: customer.id,
      rented_from: rented_from,
      rented_to: rented_to
    }
  end

  context 'when user is not authenticated' do
    let(:headers) { {} }

    it 'does not create a Rental' do
      expect { action }.to_not change { Rental.count }
    end

    it 'returns Unauthorized status' do
      action
      expect(response.status).to eq(401)
    end
  end # user not authenticated

  context 'when user is authenticated' do
    let(:token) { Knock::AuthToken.new(payload: { sub: owner.id }).token }
    let(:headers) { { 'Authorization': "Bearer #{token}" } }

    context "when the car belongs to the Owner's office" do
      it 'creates a Rental' do
        expect { action }.to change { Rental.count }.by(1)
      end

      it 'returns rental data' do
        action
        expect(JSON.parse(response.body)).to eq(
          'customer_id' => customer.id,
          'car_id' => car.id,
          'car_make' => car.make,
          'car_model' => car.model,
          'rented_from' => Rental.last.rented_from.as_json,
          'rented_to' => Rental.last.rented_to.as_json
        )
      end
    end # office valid

    context 'when the car belongs to some other office' do
      let(:other_office) { create :office }
      let(:car) { create :car, office: other_office }

      it 'does not create a Rental' do
        expect { action }.to_not change { Rental.count }
      end

      it 'returns 422 status' do
        action
        expect(response.status).to eq(422)
      end

      it 'returns error' do
        action
        expect(JSON.parse(response.body)).to eq('The car must belong to your office!')
      end
    end # office invalid

    context 'when the car is already rented, but it will be free in requested time' do
      let(:other_customer) { create :customer }
      before do
        create(
          :rental,
          customer: other_customer,
          car: car,
          rented_from: DateTime.parse(params[:rented_from].to_s) + 10.days,
          rented_to: DateTime.parse(params[:rented_to].to_s) + 12.days
        )
      end

      it 'creates a Rental' do
        expect { action }.to change { Rental.count }.by(1)
      end

      it 'returns rental data' do
        action
        expect(JSON.parse(response.body)).to eq(
          'customer_id' => customer.id,
          'car_id' => car.id,
          'car_make' => car.make,
          'car_model' => car.model,
          'rented_from' => Rental.last.rented_from.as_json,
          'rented_to' => Rental.last.rented_to.as_json
        )
      end
    end # car already rented, but free in requested time

    context 'when the car is already rented inside of requested period' do
      let(:other_customer) { create :customer }
      before do
        create(
          :rental,
          customer: other_customer,
          car: car,
          rented_from: DateTime.parse(params[:rented_from].to_s) - 1.day,
          rented_to: DateTime.parse(params[:rented_to].to_s) + 10.day
        )
      end

      it 'does not create a Rental' do
        expect { action }.to_not change { Rental.count }
      end

      it 'returns 422 status' do
        action
        expect(response.status).to eq(422)
      end

      it 'returns error' do
        action
        expect(JSON.parse(response.body)).to eq('The car is already rented to someone else!')
      end
    end # car already rented inside of requested period

    context 'when the car is already rented at the end of requested period' do
      let(:other_customer) { create :customer }
      before do
        create(
          :rental,
          customer: other_customer,
          car: car,
          rented_from: DateTime.parse(params[:rented_from].to_s) - 3.days,
          rented_to: DateTime.parse(params[:rented_to].to_s) - 1.day
        )
      end

      it 'does not create a Rental' do
        expect { action }.to_not change { Rental.count }
      end

      it 'returns 422 status' do
        action
        expect(response.status).to eq(422)
      end

      it 'returns error' do
        action
        expect(JSON.parse(response.body)).to eq('The car is already rented to someone else!')
      end
    end # car already rented at the end of requested period

    context 'when the car is already rented at the beginning of requested period' do
      let(:other_customer) { create :customer }
      before do
        create(
          :rental,
          customer: other_customer,
          car: car,
          rented_from: DateTime.parse(params[:rented_from].to_s) + 6.days,
          rented_to: DateTime.parse(params[:rented_to].to_s) + 16.days
        )
      end

      it 'does not create a Rental' do
        expect { action }.to_not change { Rental.count }
      end

      it 'returns 422 status' do
        action
        expect(response.status).to eq(422)
      end

      it 'returns error' do
        action
        expect(JSON.parse(response.body)).to eq('The car is already rented to someone else!')
      end
    end # car already rented at the beginning of requested period

    context 'when the car is already rented for whole time of requested period' do
      let(:other_customer) { create :customer }
      before do
        create(
          :rental,
          customer: other_customer,
          car: car,
          rented_from: DateTime.parse(params[:rented_from].to_s) + 2.days,
          rented_to: DateTime.parse(params[:rented_to].to_s) + 7.days
        )
      end

      it 'does not create a Rental' do
        expect { action }.to_not change { Rental.count }
      end

      it 'returns 422 status' do
        action
        expect(response.status).to eq(422)
      end

      it 'returns error' do
        action
        expect(JSON.parse(response.body)).to eq('The car is already rented to someone else!')
      end
    end # car already rented for whole time of requested period
  end # user authenticated
end
