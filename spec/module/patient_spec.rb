require 'rails_helper'

describe Patient do
  subject(:patient) {Patient.new}

  describe 'валидации' do
    it 'проверяет наличие first_name' do
      expect(patient).not_to be_valid
      expect(patient.errors.full_messages).to include("Имя не может быть пустым")
    end

  end



end
