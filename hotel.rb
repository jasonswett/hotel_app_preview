require './guest'
require './booking'

class Hotel
  attr_reader :rooms, :bookings

  def initialize(rooms)
    @rooms = rooms
    @bookings = []
  end

  def check_in_guest(guest_name)
    booking = Booking.new(vacant_room_numbers[0])
    @bookings << booking
    booking
  end

  def occupied_room_numbers
    @bookings.map(&:room_number)
  end

  def vacant_room_numbers
    @rooms - occupied_room_numbers
  end
end
