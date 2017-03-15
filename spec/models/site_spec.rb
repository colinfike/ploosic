require 'rails_helper'

RSpec.describe Site, 'site attribut testing' do
  it 'cannot save without a name' do
    site = build(:site, name: nil)
    result = site.save
    expect(result).to be false
  end

  it 'can have many tracks' do
    site = build(:site, :has_tracks)
    expect(site.tracks.count).to eq(3)
  end
end
