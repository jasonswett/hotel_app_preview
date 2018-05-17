class Hotel
  attr_accessor :guests

  def initialize
    @guests = []
    @occupied_rooms = []
  end

  def check_in_guest(guest_name, room_number)
    return false if @occupied_rooms.include?(room_number)
    @guests << guest_name
    @occupied_rooms << room_number
    true
  end

  def check_out_guest(guest_name, room_number)
    @guests.delete(guest_name)
    @occupied_rooms.delete(room_number)
  end
end
