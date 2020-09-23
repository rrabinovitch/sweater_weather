require 'rails_helper'

RSpec.describe BackgroundFacade do
  before :each do
    @background_facade = BackgroundFacade.new
  end

  it '#get_location_img' do
    location = 'denver,co'
    image = @background_facade.get_location_img(location)

    expect(image).to be_an(Image)
  end
end
