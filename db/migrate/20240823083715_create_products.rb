# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.references :category, index: true, foreign_key: true, null: false
      t.text :code, null: false
      t.timestamps
    end
  end
end
