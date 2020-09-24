require 'rails_helper'

RSpec.describe MapQuestService do
  it 'can return location data' do
    VCR.use_cassette('Denver forecast') do
      results = MapQuestService.location_data('denver,co')

      expect(results).to be_a(Hash)
      expect(results[:street]).to be_empty
      expect(results[:adminArea5]).to be_a(String)
      expect(results[:adminArea3]).to be_a(String)
      expect(results[:adminArea1]).to be_a(String)
      expect(results[:latLng]).to be_a(Hash)
      expect(results[:latLng][:lat]).to be_a(Float)
      expect(results[:latLng][:lng]).to be_a(Float)
    end
  end
end