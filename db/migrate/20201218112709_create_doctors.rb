# frozen_string_literal: true

class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :gender, null: false
      t.references :speciality, foreign_key: true, null: false
      t.timestamps
    end
  end
end
