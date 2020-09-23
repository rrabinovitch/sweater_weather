require 'rails_helper'

RSpec.describe GeoService do
  it 'can return location data' do
    VCR.use_cassette('Denver forecast') do
      geo_service = GeoService.new
      results = geo_service.location_data('denver,co')

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
