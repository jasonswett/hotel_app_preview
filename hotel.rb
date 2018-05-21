require './booking'

class Hotel
  attr_reader :rooms, :bookings

  def initialize(rooms)
    @rooms = rooms
    @bookings = []
  end

  def check_in_guest(check_in_date:, check_out_date:)
    add_booking(
      Booking.new(
        hotel: self,
        room: vacant_rooms[0],
        check_in_date: check_in_date,
        check_out_date: check_out_date
      )
    )
  end

  def add_booking(booking)
    @bookings << booking
    booking
  end

  def can_book?(booking)
    booking.valid? && room_vacant?(booking.room)
  end

  def occupied_rooms
    @bookings.map(&:room)
  end

  def vacant_rooms
    @rooms - occupied_rooms
  end

  def remove_booking(booking)
    @bookings.delete(booking)
  end

  def room_vacant?(room)
    vacant_rooms.include?(room)
  end
end
