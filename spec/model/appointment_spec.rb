require 'rails_helper'

RSpec.describe Appointment, :type => :model do

  let(:speciality) {Speciality.create!(name: 'Терапевт') }

  let(:doctor) { Doctor.create!(last_name: 'Петрова',
                                first_name: 'Фемида',
                                gender: 'female',
                                speciality: speciality) }

  let(:user) { User.create!(email: 'test@example.com', password: 'password') }

  let(:patient) { Patient.create!(last_name: "Anything",
                                  first_name: "Loremipsum",
                                  gender: "male",
                                  phone_number: "123213321",
                                  user_id: user.id) }

  let(:appointment) { Appointment.create!(doctor: doctor,
                                    patient: patient,
                                    appointed_at: DateTime.now + 1.week) }



  it "valid with valid attributes" do
    expect(appointment).to be_valid
  end

  it "destroy all attributes" do
    appointment.destroy
    doctor.destroy
    speciality.destroy
    patient.destroy
    user.destroy
  end

end
