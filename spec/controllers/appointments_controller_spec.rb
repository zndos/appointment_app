require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do

  let!(:user) { User.create!(email: 'te5689st1@example.com', password: 'password') }

  let(:speciality) {Speciality.create!(name: 'Терапевт') }

  let(:doctor) { Doctor.create!(last_name: 'Петрова',
                                first_name: 'Фемида',
                                gender: 'female',
                                speciality: speciality) }

  let(:patient) { Patient.create!(last_name: "Anything",
                                  first_name: "Loremipsum",
                                  gender: "male",
                                  phone_number: "123213321",
                                  user_id: user.id) }


  before { sign_in user }


  describe 'create' do
    it 'successfully creates a new appointment' do

      expect{
        post :create, params: { :appointment => {appointed_at: DateTime.now }, :doctor_id => doctor.id }
      }.to change{Appointment.count}.by(0)

    end
  end


end
