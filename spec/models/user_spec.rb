require 'rails_helper'

RSpec.describe User, "validations" do
  it { is_expected.to validate_presence_of(:guest_hash) }
end
