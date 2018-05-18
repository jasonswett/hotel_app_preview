require 'rspec'
require './hotel'
require './booking'

describe Booking do
  describe 'when all rooms are vacant' do
    it 'assigns the first room number' do
      hotel = Hotel.new([100, 101, 102, 103])
      booking = hotel.check_in_guest('George Harrison')
      expect(booking.room_number).to eq(100)
    end
  end

  describe 'when one room is occupied' do
    it 'assigns the next room number' do
      hotel = Hotel.new([100, 101, 102, 103])

      first_booking = hotel.check_in_guest('George Harrison')
      second_booking = hotel.check_in_guest('Roy Orbison')

      expect(second_booking.room_number).to eq(101)
    end
  end
end
