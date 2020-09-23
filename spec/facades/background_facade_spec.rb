require 'rails_helper'

RSpec.describe BackgroundFacade do
  it '#get_location_img' do
    VCR.use_cassette('Denver image search') do
      background_facade = BackgroundFacade.new
      location = 'denver,co'
      image = background_facade.get_location_img(location)

      expect(image).to be_an(Image)
    end
  end
end
