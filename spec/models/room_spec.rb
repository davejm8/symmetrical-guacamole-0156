require 'rails_helper'

RSpec.describe Room, type: :model do
  
  describe 'relationships' do
    it {should belong_to :hotel}
    it {should have_many :guest_rooms}
    it {should have_many(:guests).through(:guest_rooms)}
  end
  
  describe 'instance methods' do
    
    it "::count_guests" do
      @holliday = Hotel.create!(name: 'Holliday Inn', location: 'Buxton') 
      @harbor = Hotel.create!(name: 'Portland Harbor', location: 'Portland') 
      @room_1 = @harbor.rooms.create!(rate: 180, suite: "Presidential")
      @room_2 = @harbor.rooms.create!(rate: 185, suite: "Vice-Presidential")
      @room_3 = @holliday.rooms.create!(rate: 160, suite: "Honeymoon")
      @room_4 = @holliday.rooms.create!(rate: 10, suite: "Broom Closet")
      @steve = Guest.create!(name: 'Steve', nights: 3) 
      @dave = Guest.create!(name: 'Dave', nights: 5) 
      @jim = Guest.create!(name: 'Jim', nights: 1)
      GuestRoom.create!(room: @room_1, guest: @jim)

      expect(@room_1.count_guests).to eq(1)
    end
  end
end