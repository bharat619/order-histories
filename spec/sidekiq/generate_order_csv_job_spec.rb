# frozen_string_literal: true

require 'rails_helper'

describe GenerateOrderCsvJob do
  subject(:perform) { described_class.new.perform(user.id) }

  let(:user) { User.find_by(email: 'john.doe@example.com') }
  let(:server) { ActionCable.server }
  let(:orders) { Order.where(user:) }
  let(:expected_attrs) do
    res = []

    orders.map do |order|
      res << {
        category_name: order.product.category.name,
        code: order.product.code,
        email: user.email,
        product_name: order.product.name,
        order_date: order.created_at.strftime('%d-%m-%Y'),
        username: user.username
      }
    end
    res
  end

  before do
    ImportUsers.call
    ImportProducts.call
    ImportOrders.call

    allow(ActionCable).to receive(:server).and_return(server)
  end

  it 'boroadcase the order details' do
    expect(server).to receive(:broadcast).with('order_stream', expected_attrs)

    subject
  end
end
