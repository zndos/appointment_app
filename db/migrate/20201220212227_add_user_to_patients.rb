# frozen_string_literal: true

class AddUserToPatients < ActiveRecord::Migration[6.0]
  def change
    add_reference :patients, :user, null: false, foreign_key: true
  end
end
