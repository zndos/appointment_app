require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { User.create!(email: 'test@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid with nil attributes' do
    user.password = "t"*256
    expect(user).to_not be_valid
  end

end
