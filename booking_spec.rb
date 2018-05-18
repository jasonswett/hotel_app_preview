require 'rspec'
require './hotel'
require './booking'

describe Booking do
  it 'assigns a room number' do
    hotel = Hotel.new([100, 101, 102, 103])
    booking = hotel.check_in_guest('George Harrison')
    expect(hotel.rooms).to include(booking.room_number)
  end
end
