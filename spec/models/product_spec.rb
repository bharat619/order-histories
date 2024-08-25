# frozen_string_literal: true

require 'rails_helper'

describe Product, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
end
