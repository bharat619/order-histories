# frozen_string_literal: true

require 'rails_helper'

describe '/users', type: :request do
  subject(:request) { get api_v1_users_path }

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

  before do
    stub_const('ImportUsers::USER_CSV_PATH', Rails.root.join('data', 'test', 'users.csv'))

    ImportData.call
  end

  it 'gets a list of users' do
    subject
    expect(response_body).to match_array(expected)
  end
end
