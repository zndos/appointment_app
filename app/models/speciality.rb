# frozen_string_literal: true

class Speciality < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  def to_s
    name
  end


  def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
  where("name LIKE ?", "%#{search}%")
  end

end
