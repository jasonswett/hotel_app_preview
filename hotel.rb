require './guest'
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
        room_number: vacant_room_numbers[0],
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
    room_vacant?(booking.room_number)
  end

  def occupied_room_numbers
    @bookings.map(&:room_number)
  end

  def vacant_room_numbers
    @rooms - occupied_room_numbers
  end

  def remove_booking(booking)
    @bookings.delete(booking)
  end

  def room_vacant?(room_number)
    vacant_room_numbers.include?(room_number)
  end
end
