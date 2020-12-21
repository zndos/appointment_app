require 'rails_helper'

describe Speciality do

  let(:otolaryngologist) { Speciality.new }
  let(:psychoterapist) { Speciality.create!(name: 'Терапевт') }

  describe 'валидации' do

    it 'проверяет наличие name' do
      expect(otolaryngologist).not_to be_valid
    end



    it 'проверяет наличие name' do
      expect(psychoterapist).to be_valid
    end
  end

end
