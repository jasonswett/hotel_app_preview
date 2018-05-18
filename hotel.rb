require './guest'

class Hotel
  attr_accessor :guests

  def initialize
    @guests = []
    @occupied_rooms = []
  end

  def check_in_guest(guest_name, room_number)
    return false if @occupied_rooms.include?(room_number)
    @guests << Guest.new(guest_name)
    @occupied_rooms << room_number
    true
  end

  def guest_names
    @guests.map(&:name)
  end

  def find_guest(guest_name)
    @guests.detect { |g| g.name == guest_name }
  end

  def check_out_guest(guest_name, room_number)
    @guests.delete(find_guest(guest_name))
    @occupied_rooms.delete(room_number)
  end
end
