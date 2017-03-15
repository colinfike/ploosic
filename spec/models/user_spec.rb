require 'rails_helper'

RSpec.describe User, 'user attribute tests' do
  it 'cannot save without a username' do
    user = build(:user, username: nil)
    result = user.save
    expect(result).to be false
  end
end
