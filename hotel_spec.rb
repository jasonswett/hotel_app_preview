require 'rspec'
require './hotel'
require './room'

describe Hotel do
  let(:hotel) do
    Hotel.new([
      Room.new(number: 100, rate: 150),
      Room.new(number: 101, rate: 150),
      Room.new(number: 102, rate: 150),
      Room.new(number: 103, rate: 150)
    ])
  end

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

  describe '#occupied_rooms' do
    it 'returns the numbers of any occupied rooms' do
      hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(hotel.occupied_rooms.first.number).to eq(100)
    end
  end

  describe '#vacant_rooms' do
    it 'returns the numbers of any vacant rooms' do
      hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(hotel.vacant_rooms.map(&:number)).to eq([101, 102, 103])
    end
  end

  describe 'when all rooms are vacant' do
    it 'assigns the first room number' do
      booking = hotel.check_in_guest(
        check_in_date: '2018-01-01',
        check_out_date: '2018-01-02'
      )

      expect(booking.room.number).to eq(100)
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

      expect(second_booking.room.number).to eq(101)
    end
  end

  describe '#can_book?' do
    context 'when room is occupied' do
      it 'returns false' do
        previous_booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )
        hotel.add_booking(previous_booking)

        booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-01',
          check_out_date: '2018-01-02'
        )

        expect(hotel.can_book?(booking)).to be false
      end
    end

    context 'booking itself is invalid' do
      it 'returns false' do
        booking = Booking.new(
          hotel: hotel,
          room: Room.new(number: 100, rate: 150),
          check_in_date: '2018-01-02',
          check_out_date: '2018-01-01'
        )

        expect(hotel.can_book?(booking)).to be false
      end
    end
  end
end
