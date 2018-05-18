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
end
