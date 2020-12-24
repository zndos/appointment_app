require 'rails_helper'

RSpec.describe Speciality, :type => :model do
  man = User.create(email: "jane@doe.com", password: "pw1234",encrypted_password: "",
                    created_at: DateTime.now,updated_at: DateTime.now + 1.week)

  it 'is not valid with nil attributes' do
    man.name = nil
    expect(man).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(man).to be_valid
  end




end
