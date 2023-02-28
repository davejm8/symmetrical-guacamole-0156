require 'rails_helper'

RSpec.describe GuestRoom, type: :model do
  it {should belong_to :guest}
  it {should belong_to :room }
end
