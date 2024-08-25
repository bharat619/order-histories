# frozen_string_literal: true

class Product < ApplicationRecord
  # relationships
  has_many :orders
  belongs_to :category

  # validations
  validates :name, presence: true, allow_nil: false
  validates :code, presence: true, uniqueness: true, allow_nil: false
end
