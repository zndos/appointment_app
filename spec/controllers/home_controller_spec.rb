require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:user) { User.create!(email: 'te5689st1@example.com', password: 'password') }
  before { sign_in user }

  describe 'index' do
    it 'show all doctors' do

      # expect{
      #   post :get, params:  {:controller=>"home", :action=>"index"}
      #   }.to_not eq(Doctor.eager_load(:speciality).all)

    end
  end


end
