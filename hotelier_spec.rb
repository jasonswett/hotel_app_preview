require 'rspec'

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

describe Hotel do
  let(:hotel) { Hotel.new }

  describe 'checking in a guest' do
    context 'room is available' do
      it 'allows check-in' do
        expect(hotel.check_in_guest('George Harrison', 302)).to be true
      end

      it "adds the guest to the hotel's guest list" do
        hotel.check_in_guest('George Harrison', 302)
        expect(hotel.guests).to include 'George Harrison'
      end
    end

    context 'room is not available' do
      it 'disallows check-in' do
        hotel.check_in_guest('Roy Orbison', 302)
        expect(hotel.check_in_guest('George Harrison', 302)).to be false
      end

      it "does not add the guest to the hotel's guest list" do
        hotel.check_in_guest('Roy Orbison', 302)
        hotel.check_in_guest('George Harrison', 302)
        expect(hotel.guests).not_to include 'George Harrison'
      end
    end
  end

  describe 'checking out a guest' do
    it "removes the guest from the hotel's guest list" do
      hotel.check_in_guest('Buddy Holly', 303)
      hotel.check_out_guest('Buddy Holly', 303)
      expect(hotel.guests).not_to include 'Buddy Holly'
    end

    it 'frees up the room' do
      hotel.check_in_guest('Roy Orbison', 302)
      hotel.check_out_guest('Roy Orbison', 302)
      expect(hotel.check_in_guest('George Harrison', 302)).to be true
    end
  end
end
