require 'rails_helper'

RSpec.describe Patient, :type => :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password') }
  let(:patient) { Patient.create!(last_name: "Anything",
                                  first_name: "Loremipsum",
                                  gender: "male",
                                  phone_number: "123213321",
                                  user_id: user.id) }



  it "'first_name should be less then 255 symbols" do
    patient.first_name = "t" * 256
    expect(patient).to_not be_valid
    patient.first_name = "john"
  end

  it "is not valid without first_name " do
    patient.first_name = nil
    expect(patient).to_not be_valid
  end

  it "is not valid without last_name " do
    patient.first_name = nil
    expect(patient).to_not be_valid
  end

  it "is not valid without gender" do
    patient.gender = nil
    expect(patient).to_not be_valid
  end

  it "is not valid without phone_number" do
    patient.phone_number = nil
    expect(patient).to_not be_valid
  end

end
