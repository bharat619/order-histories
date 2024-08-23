require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(User.new(email: nil, username: 'abcd', phone: '123-456')).not_to be_valid }
  it { expect(User.new(email: 'abcd', username: 'abcd', phone: '123-456')).not_to be_valid }
  it { expect(User.new(email: 'abc@def.com', username: 'abcd', phone: '123-456')).to be_valid }
end
