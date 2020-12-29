require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do

  let(:speciality) { Speciality.create!(name: 'Терапевт') }
  let!(:user) { User.create!(email: 'te5689st1@example.com', password: 'password') }
  before { sign_in user }


  describe 'create' do
    it 'successfully creates a new doc' do

      expect{
        post :create, params: { :doctor => { last_name: 'Петрова',
                                                 first_name: 'Фемида',
                                                 gender: 'female',
                                                 speciality_id: 92 } }
      }.to change{Doctor.count}.by(1)

    end
  end


end
