# frozen_string_literal: true

class Product < ApplicationRecord
  # relationships
  has_one :category
  has_many :orders
  belongs_to :category

  # validations
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true, allow_nil: false
end
