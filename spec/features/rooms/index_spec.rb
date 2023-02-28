require 'rails_helper'

RSpec.describe 'index view' do
  let!(:holliday) { Hotel.create!(name: 'Holliday Inn', location: 'Buxton') }
  let!(:harbor) { Hotel.create!(name: 'Portland Harbor', location: 'Portland') }
  let!(:room_1) { harbor.rooms.create!(rate: 180, suite: "Presidential")}
  let!(:room_2) { harbor.rooms.create!(rate: 185, suite: "Vice-Presidential")}
  let!(:room_3) { holliday.rooms.create!(rate: 160, suite: "Honeymoon")}
  let!(:room_4) { holliday.rooms.create!(rate: 10, suite: "Broom Closet")}
  let!(:steve) { room_1.guests.create!(name: 'Steve', nights: 3) }
  let!(:dave) { room_2.guests.create!(name: 'Dave', nights: 5) }
  let!(:jim) { room_3.guests.create!(name: 'Jim', nights: 1)}

  it 'lists all rooms and associated attributes' do
    
    GuestRoom.create!(guest: steve, room: room_1)
    GuestRoom.create!(guest: dave, room: room_1)
    GuestRoom.create!(guest: steve, room: room_2)
    GuestRoom.create!(guest: dave, room: room_3)
    GuestRoom.create!(guest: dave, room: room_4)
    
    visit '/rooms'

   

    

    expect(page).to have_content("#{room_3.suite}")
    expect(page).to have_content("Rate: #{room_3.rate}")
    expect(page).to have_content("Hotel: #{holliday.name}")
    expect(page).to have_content("Rented: #{room_3.count_guests}")
  end
end