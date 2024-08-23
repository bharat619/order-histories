# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_presence_of :created_at
end
