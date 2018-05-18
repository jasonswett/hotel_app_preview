require 'rspec'
require './hotel'
require './booking'

describe Booking do
  let(:hotel) { Hotel.new([100, 101, 102, 103]) }

  describe '#complete' do
    it 'frees up the room' do
      booking = hotel.check_in_guest('Elvis Presley')
      booking.complete

      expect(hotel.vacant_room_numbers).to include(booking.room_number)
    end
  end
end
