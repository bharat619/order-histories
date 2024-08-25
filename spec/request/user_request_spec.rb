# frozen_string_literal: true

require 'rails_helper'

describe 'User', type: :request do
  subject(:request) { get request_url }

  let!(:generate_spy) { class_spy(GenerateOrderCsvJob).as_stubbed_const }

  before do
    stub_const('ImportUsers::USER_CSV_PATH', Rails.root.join('data', 'test', 'users.csv'))
    ImportData.call
  end

  context '/users' do
    let(:request_url) { api_v1_users_path }
    let(:response_body) { JSON.parse(response.body) }
    let(:expected) do
      User.all.map do |u|
        { 'id' => u.id,
          'username' => u.username,
          'email' => u.email,
          'phone' => u.phone,
          'created_at' => u.created_at.as_json,
          'updated_at' => u.updated_at.as_json }
      end
    end

    it 'gets a list of users' do
      subject
      expect(response_body).to match_array(expected)
    end
  end

  context '/users/:id/export_order' do
    let(:request_url) { export_order_api_v1_user_path(user.id) }
    let(:user) { User.first }

    it 'renders an ok response' do
      subject
      expect(response).to have_http_status :ok
    end

    it 'schedules the worker' do
      subject
      expect(generate_spy).to have_received(:perform_async).with(user.id.to_s)
    end
  end
end
