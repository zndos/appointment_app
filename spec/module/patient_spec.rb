require 'rails_helper'


RSpec.describe Patient, :type => :model do
  man = User.create(email: "jane@doe.com", password: "pw1234",encrypted_password: "",
                    created_at: DateTime.now,updated_at: DateTime.now + 1.week)

  pat = Patient.create(last_name: "Anything",
                       first_name: "Lorem ipsum",
                       gender: "male",
                       phone_number: "123213321",
                       user_id: man.id)
  after(:all) do
    pat.destroy!
    man.destroy
  end

  it "'first_name should be less then 255 symbols" do
    pat.first_name = "t"*256
    expect(pat).to_not be_valid
  end

  it "valid with valid attributes" do
    expect(pat).to be_valid
  end

  it "is not valid without first_name " do
    pat.first_name = nil
    expect(pat).to_not be_valid
  end

  it "is not valid without last_name " do
    pat.first_name = nil
    expect(pat).to_not be_valid
  end


  it "is not valid without gender" do
    pat.gender = nil
    expect(pat).to_not be_valid
  end


  it "is not valid without phone_number" do
    pat.phone_number = nil
    expect(pat).to_not be_valid
  end

end
