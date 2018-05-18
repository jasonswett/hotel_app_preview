require 'rspec'
require './hotel'

describe Hotel do
  let(:hotel) { Hotel.new([100, 101, 102, 103]) }

  describe '#check_in_guest' do
    it "adds a booking to the hotel's bookings" do
      expect {
        hotel.check_in_guest(
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

      }.to change { hotel.bookings.count }.by(1)
    end
  end

  describe '#occupied_room_numbers' do
    it 'returns the numbers of any occupied rooms' do
      hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(hotel.occupied_room_numbers).to eq([100])
    end
  end

  describe '#vacant_room_numbers' do
    it 'returns the numbers of any vacant rooms' do
      hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(hotel.vacant_room_numbers).to eq([101, 102, 103])
    end
  end

  describe 'when all rooms are vacant' do
    it 'assigns the first room number' do
      booking = hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(booking.room_number).to eq(100)
    end
  end

  describe 'when one room is occupied' do
    it 'assigns the next room number' do
      first_booking = hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      second_booking = hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(second_booking.room_number).to eq(101)
    end
  end

  describe '#can_book?' do
    context 'when room is occupied' do
      it 'returns false' do
        previous_booking = Booking.new(
          hotel: hotel,
          room_number: 100,
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )
        hotel.add_booking(previous_booking)

        booking = Booking.new(
          hotel: hotel,
          room_number: 100,
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(hotel.can_book?(booking)).to be false
      end
    end
  end
end
