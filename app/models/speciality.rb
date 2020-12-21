# frozen_string_literal: true

class Speciality < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  def to_s
    name
  end

  def self.search(search)
    if search
      speciality = Speciality.find_by(name: search)
      if speciality
        self.where(speciality_id: speciality)
      else
        Speciality.all
      end
    else
      Speciality.all
    end
  end
end
