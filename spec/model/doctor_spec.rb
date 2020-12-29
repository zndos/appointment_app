require 'rails_helper'

RSpec.describe Doctor, :type => :model do

  let(:speciality) { Speciality.create!(name: 'Терапевт') }

  let(:doctor) { Doctor.create!(last_name: 'Петрова',
                                first_name: 'Фемида',
                                gender: 'female',
                                speciality: speciality) }

  it 'is validate with valid attributes' do
    expect(doctor).to be_valid
  end

  it 'has speciality' do
    doctor.speciality = nil
    expect(doctor).to_not be_valid
    doctor.speciality = speciality
  end

  it 'has last_name' do
    doctor.last_name = nil
    expect(doctor).to_not be_valid
    doctor.last_name = 'Петрова'
  end

  it 'has first_name' do
    doctor.first_name = nil
    expect(doctor).to_not be_valid
    doctor.first_name = 'Фемида'
  end

  it 'has gender' do
    doctor.gender = nil
    expect(doctor).to_not be_valid
    doctor.gender = 'female'
  end

  it " 's first_name should be less then 255 symbols" do
    doctor.first_name = "t" * 256
    expect(doctor).to_not be_valid
    doctor.first_name = 'Фемида'
  end

  it " 's last_name should be less then 255 symbols" do
    doctor.last_name = "t" * 256
    expect(doctor).to_not be_valid
    doctor.last_name = 'Петрова'
  end

end
