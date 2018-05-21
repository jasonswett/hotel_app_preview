class Booking
  attr_accessor :room_number
  ROOM_PRICE = 150

  def initialize(hotel:, room_number:, check_in_date:, check_out_date:)
    @hotel = hotel
    @room_number = room_number
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
  end

  def valid?
    @check_out_date > @check_in_date && @hotel.is_a?(Hotel) && @room_number.is_a?(Integer)
  end

  def complete
    @hotel.remove_booking(self)
  end

  def length_in_days
    @check_out_date - @check_in_date
  end

  def price
    ROOM_PRICE * length_in_days
  end
end
