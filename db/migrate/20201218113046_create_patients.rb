# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :gender, null: false
      t.date :birthday
      t.string :phone_number, null: false, default: ''
      t.timestamps
    end
  end
end
