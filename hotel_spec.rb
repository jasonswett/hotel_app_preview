require 'rspec'
require './hotel'

describe Hotel do
  let(:hotel) { Hotel.new([100, 101, 102, 103]) }

  describe '#check_in_guest' do
    it "adds a booking to the hotel's bookings" do
      expect {
        hotel.check_in_guest('Elvis Presley')
      }.to change { hotel.bookings.count }.by(1)
    end
  end

  describe '#occupied_room_numbers' do
    it 'returns the numbers of any occupied rooms' do
      hotel.check_in_guest('Elvis Presley')
      expect(hotel.occupied_room_numbers).to eq([100])
    end
  end

  describe '#vacant_room_numbers' do
    it 'returns the numbers of any vacant rooms' do
      hotel.check_in_guest('Elvis Presley')
      expect(hotel.vacant_room_numbers).to eq([101, 102, 103])
    end
  end

  describe 'when all rooms are vacant' do
    it 'assigns the first room number' do
      booking = hotel.check_in_guest('George Harrison')
      expect(booking.room_number).to eq(100)
    end
  end

  describe 'when one room is occupied' do
    it 'assigns the next room number' do
      first_booking = hotel.check_in_guest('George Harrison')
      second_booking = hotel.check_in_guest('Roy Orbison')

      expect(second_booking.room_number).to eq(101)
    end
  end
end
