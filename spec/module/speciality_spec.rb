require 'rails_helper'

RSpec.describe Speciality, :type => :model do
  subject {
    described_class.new(
     name: 'sad')
  }
  it 'is not valid with nil attributes' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is  valid with valid attributes' do
    subject.name = "Terapevt"
    expect(subject).to be_valid
  end

  it 'is not valid with name > 255 symbols' do
    subject.name = "T"*256
    expect(subject).to_not be_valid
  end

end
