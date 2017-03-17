require 'rails_helper'

RSpec.describe Site, "validations" do
  it { is_expected.to validate_presence_of(:name) }
end

RSpec.describe Site, 'obsolete association testing' do
  it 'can have many tracks' do
    site = build(:site, :has_tracks)
    expect(site.tracks.count).to eq(3)
  end
end
