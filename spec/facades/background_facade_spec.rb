require 'rails_helper'

RSpec.describe BackgroundFacade do
  it '::get_location_img' do
    VCR.use_cassette('Denver image search') do
      location = 'denver,co'
      image = BackgroundFacade.get_location_img(location)

      expect(image).to be_an(Image)
    end
  end
end
