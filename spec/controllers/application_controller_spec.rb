require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { User.create!(email: 'te5689st1@example.com', password: 'password') }
  before { sign_in user }



end
