require 'rails_helper'

RSpec.describe RoadTripFacade do
  it '::get_road_trip' do
    VCR.use_cassette('Denver to Pueblo road trip') do
      origin = 'Denver, CO'
      destination = 'Pueblo, CO'
      user = create(:user)

      road_trip = RoadTripFacade.get_road_trip(origin, destination, user)
      expect(road_trip).to be_a(RoadTrip)
    end
  end
end
