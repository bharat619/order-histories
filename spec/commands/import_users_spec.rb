# frozen_string_literal: true

require 'rails_helper'

describe ImportUsers do
  subject(:command) { described_class.call }

  context 'when uploading valid CSV' do
    before do
      stub_const('ImportUsers::USER_CSV_PATH', Rails.root.join('data', 'test', 'users.csv'))
    end

    it 'creates the user records' do
      expect { command }.to change { User.count }.by(5)
    end
  end

  context 'when uploading invalid CSV' do
    before do
      stub_const('ImportUsers::USER_CSV_PATH', Rails.root.join('data', 'test', 'users_invalid.csv'))
    end

    it 'does not create the user records' do
      expect { command }.to raise_error(ActiveRecord::Rollback)
    end
  end
end
