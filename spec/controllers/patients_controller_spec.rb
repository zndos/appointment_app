require 'rails_helper'

RSpec.describe PatientsController, type: :controller do

  let!(:user) { User.create!(email: 'te5689123st1@exle.com', password: 'password') }
  before { sign_in user }


  describe 'create' do
    it 'successfully creates a new patient' do

      expect{
        post :update, params: { :patient => { last_name: "Anything",
                                             first_name: "Loremipsum",
                                             gender: "male",
                                             phone_number: "123213321",
                                             user_id: user.id } }
      }.to change{Patient.count}.by(1)

    end
  end


end
