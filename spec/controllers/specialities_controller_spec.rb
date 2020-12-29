require 'rails_helper'

RSpec.describe SpecialitiesController, type: :controller do
  let!(:user) { User.create!(email: 'te5689st1@example.com', password: 'password') }
  before { sign_in user }


  describe 'create' do
    it 'successfully creates a new sp' do

      expect{
        post :create, params: { :speciality => { :name => "Psycho" } }
      }.to change{Speciality.count}.by(1)

    end
  end


end
