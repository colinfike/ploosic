require 'rails_helper'

RSpec.describe TrackUserStat, "validations" do
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:track) }
end
