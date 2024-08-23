# frozen_string_literal: true

require 'rails_helper'

describe ImportOrders do
  subject(:command) { described_class.call }
  before do
    stub_const('ImportUsers::USER_CSV_PATH', Rails.root.join('data', 'test', 'users.csv'))
    stub_const('ImportUsers::CSV_PATH', Rails.root.join('data', 'test', 'products.csv'))
    ImportUsers.call
    ImportProducts.call
  end

  context 'when uploading valid CSV' do
    before do
      stub_const('ImportOrders::CSV_PATH', Rails.root.join('data', 'test', 'order_details.csv'))
    end

    it 'creates the order records' do
      expect { command }.to change { Order.count }.by(5)
    end

    context 'when orders csv contains product code which is not present in products table' do
      before do
        stub_const('ImportOrders::CSV_PATH', Rails.root.join('data', 'test', 'order_details_invalid_product_code.csv'))
      end

      it 'creates the order records' do
        expect { command }.to change { Order.count }.by(4)
      end
    end

    context 'when orders csv contains user which is not present in users table' do
      before do
        stub_const('ImportOrders::CSV_PATH', Rails.root.join('data', 'test', 'order_details_invalid_user.csv'))
      end

      it 'creates the order records' do
        expect { command }.to change { Order.count }.by(3)
      end
    end
  end

  context 'when uploading invalid CSV' do
    context 'if the date is empty in the column' do
      before do
        stub_const('ImportOrders::CSV_PATH', Rails.root.join('data', 'test', 'order_details_invalid_date.csv'))
      end

      it 'does not create the user records' do
        expect { command }.to raise_error(ActiveRecord::Rollback)
      end
    end

    context 'if the date is invalid in the column' do
      before do
        stub_const('ImportOrders::CSV_PATH', Rails.root.join('data', 'test', 'order_details_empty_date.csv'))
      end

      it 'does not create the user records' do
        expect { command }.to raise_error(ActiveRecord::Rollback)
      end
    end
  end
end
