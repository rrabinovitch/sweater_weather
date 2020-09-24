require 'rails_helper'

RSpec.describe PexelsService do
  it 'can return image data based on a location search' do
    location = 'Denver, CO'
    results = PexelsService.img_by_location(location)

    expect(results).to be_a(Hash)
    expect(results[:url]).to be_a(String)
    expect(results[:photographer]).to be_a(String)
  end
end
