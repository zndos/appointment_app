# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :speciality

  # определяем единственные значения для поля gender,
  # а тек же настраивает привязку к соответствующему значению в БД
  enum gender: { male: 'male', female: 'female' }

  validates :last_name,
            :first_name,
            presence: true,
            length: { maximum: 255 }
  validates :gender,
            presence: true

  def to_s
    "#{last_name} #{first_name}"
  end
end
