require 'rails_helper'

RSpec.describe Image do
  it 'has attributes' do
    img_data = {:url=>'www.url.com',
                :photographer=>'mr. photographer'}
    location = 'denver,co'

    image = Image.new(img_data, location)

    img_credit = { source: "pexels.com",
                photographer: img_data[:photographer] }

    expect(image).to be_an(Image)
    expect(image.id).to eq(nil)
    expect(image.location).to eq(location)
    expect(image.credit).to eq(img_credit)
  end
end
