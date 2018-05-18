class Booking
  attr_accessor :room_number

  def initialize(hotel, room_number)
    @hotel = hotel
    @room_number = room_number
  end

  def complete
    @hotel.remove_booking(self)
  end
end
