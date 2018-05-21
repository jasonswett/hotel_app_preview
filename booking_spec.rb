require 'rspec'
require './hotel'
require './booking'
require './room'

describe Booking do
  let(:hotel) { Hotel.new([100, 101, 102, 103]) }

  describe '#complete' do
    it 'frees up the room' do
      booking = Booking.new(
        hotel: hotel,
        room: Room.new(number: 100, rate: 150),
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )
      booking.complete

      expect(hotel.vacant_rooms).to include(booking.room.number)
    end
  end

  describe '#length_in_days' do
    it 'returns the length of the stay' do
      booking = Booking.new(
        hotel: hotel,
        room: Room.new(number: 100, rate: 150),
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-03'
      )

      expect(booking.length_in_days).to eq(2)
    end
  end

  describe '#price' do
    it 'returns the price' do
      booking = Booking.new(
        hotel: hotel,
        room: Room.new(number: 100, rate: 150),
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-03'
      )

      expect(booking.price).to eq(300)
    end
  end

  describe '#valid?' do
    context 'when everything is okay' do
      it 'is valid' do
        booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(booking).to be_valid
      end
    end

    context 'when check_out_date precedes check_in_date' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-05',
          check_out_date: '2018-01-01'
        )

        expect(booking).not_to be_valid
      end
    end

    context 'when stay length is 0 days' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-01'
        )

        expect(booking).not_to be_valid
      end
    end

    context 'when hotel is invalid' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: 'not a hotel',
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(booking).not_to be_valid
      end
    end

    context 'when room number is invalid' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: hotel,
          room: 'not a room',
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(booking).not_to be_valid
      end
    end
  end
end
