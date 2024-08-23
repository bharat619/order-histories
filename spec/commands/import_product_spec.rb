# frozen_string_literal: true

require 'rails_helper'

describe ImportProducts do
  subject(:command) { described_class.call }

  context 'when uploading valid CSV' do
    before do
      stub_const('ImportProducts::CSV_PATH', Rails.root.join('data', 'test', 'products.csv'))
    end

    it 'creates the products records' do
      expect { command }.to change { Product.count }.by(5)
    end

    context 'when there are repetative categories in the csv' do
      it 'creates new category record for new category entry in the csv' do
        expect { command }.to change { Category.count }.by(3)
      end
    end

    context 'when there is duplicate product code' do
      it 'does not create product record for it' do
        command

        # refer data/test/products.csv
        product = Product.find_by(code: 'P005')
        expect(product.name).to eq('Revenant - Hardcover')
        expect(product.category.name).to eq('Books')
      end
    end
  end

  context 'when CSV has invalid name' do
    before do
      stub_const('ImportProducts::CSV_PATH', Rails.root.join('data', 'test', 'products_invalid_code.csv'))
    end

    it 'does not create the product records' do
      expect { command }.to raise_error(ActiveRecord::Rollback)
    end
  end

  context 'when CSV has invalid name' do
    before do
      stub_const('ImportProducts::CSV_PATH', Rails.root.join('data', 'test', 'products_invalid_name.csv'))
    end

    it 'does not create the product records' do
      expect { command }.to raise_error(ActiveRecord::Rollback)
    end
  end

  context 'when CSV has invalid category' do
    before do
      stub_const('ImportProducts::CSV_PATH', Rails.root.join('data', 'test', 'products_invalid_category.csv'))
    end

    it 'does not create the product records' do
      expect { command }.to raise_error(ActiveRecord::Rollback)
    end
  end
end
