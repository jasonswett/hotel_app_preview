require 'rspec'
require './hotel'
require './booking'

describe Booking do
  let(:hotel) { Hotel.new([100, 101, 102, 103]) }

  describe '#complete' do
    it 'frees up the room' do
      booking = Booking.new(
        hotel: hotel,
        room_number: 100,
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )
      booking.complete

      expect(hotel.vacant_room_numbers).to include(booking.room_number)
    end
  end

  describe '#length_in_days' do
    it 'returns the length of the stay' do
      booking = Booking.new(
        hotel: hotel,
        room_number: 100,
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-03'
      )

      expect(booking.length_in_days).to eq(2)
    end
  end

  describe '#valid?' do
    context 'when everything is okay' do
      it 'is valid' do
        booking = Booking.new(
          hotel: hotel,
          room_number: 100,
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
          room_number: 100,
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
          room_number: 100,
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
          room_number: 100,
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
          room_number: 'not a room number',
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(booking).not_to be_valid
      end
    end

    context 'when check in date is invalid' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: hotel,
          room_number: 100,
          check_in_date: 'not a date',
          check_out_date: '2018-01-02'
        )

        expect(booking).not_to be_valid
      end
    end

    context 'when check out date is invalid' do
      it 'is not valid' do
        booking = Booking.new(
          hotel: hotel,
          room_number: 100,
          check_in_date: '2018-01-01',
          check_out_date: 'not a date'
        )

        expect(booking).not_to be_valid
      end
    end
  end
end
