require 'rails_helper'

RSpec.describe MapQuestService do
  it 'can return location data' do
    # VCR.use_cassette('Denver forecast') do
      results = MapQuestService.location_data('denver,co')

      expect(results).to be_a(Hash)
      expect(results[:adminArea5]).to be_a(String)
      expect(results[:adminArea3]).to be_a(String)
      expect(results[:adminArea1]).to be_a(String)
      expect(results[:latLng]).to be_a(Hash)
      expect(results[:latLng][:lat]).to be_a(Float)
      expect(results[:latLng][:lng]).to be_a(Float)
    # end
  end

  it 'can return directions data' do
    # VCR.use_cassette('Denver to Pueblo road trip') do
      origin = 'Denver, CO'
      destination = 'Pueblo, CO'
      results = MapQuestService.directions_data(origin, destination)

      expect(results).to be_a(Hash)
      expect(results[:time]).to be_an(Integer)
    # end
  end
end
