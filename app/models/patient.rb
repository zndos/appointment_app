# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :user

  # определяем единственные значения для поля gender,
  # а тек же настраивает привязку к соответствующему значению в БД
  enum gender: { male: 'male', female: 'female' }

  validates :last_name,
            :first_name,
            presence: true,
            length: { maximum: 255 }
  validates :gender, :phone_number,
            presence: true
end
