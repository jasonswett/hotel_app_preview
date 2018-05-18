require './guest'
require './booking'

class Hotel
  attr_reader :rooms

  def initialize(rooms)
    @rooms = rooms
  end

  def check_in_guest(guest_name)
    Booking.new(@rooms[0])
  end
end
