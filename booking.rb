class Booking
  attr_accessor :room

  def initialize(hotel:, room:, check_in_date:, check_out_date:)
    @hotel = hotel
    @room = room
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
  end

  def valid?
    @check_out_date > @check_in_date && @hotel.is_a?(Hotel) && @room.is_a?(Room)
  end

  def complete
    @hotel.remove_booking(self)
  end

  def length_in_days
    @check_out_date - @check_in_date
  end

  def price
    @room.rate * length_in_days
  end
end
