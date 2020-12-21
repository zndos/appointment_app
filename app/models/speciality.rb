# frozen_string_literal: true

class Speciality < ApplicationRecord
  validates :name, length: { maximum: 255 }

  def to_s
    name
  end
end
