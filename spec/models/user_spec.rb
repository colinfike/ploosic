require 'rails_helper'

RSpec.describe User, "validations" do
end

RSpec.describe User, "callbacks" do
  it 'should create playlist on save' do
    user = User.create
    user.save
    expect(user.playlist).not_to be_nil
  end
end
