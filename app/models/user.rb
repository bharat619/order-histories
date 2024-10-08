# frozen_string_literal: true

class User < ApplicationRecord
  # relationships
  has_many :orders
  # validations

  validates :username, presence: true, allow_nil: false
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/, presence: true
  validates :email,
            uniqueness: { message: 'has already been taken.' }
end
