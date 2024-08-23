# frozen_string_literal: true

require 'rails_helper'

describe Order, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }
  it { should validate_presence_of(:created_at) }
end
