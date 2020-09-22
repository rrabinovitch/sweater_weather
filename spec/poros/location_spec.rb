require 'rails_helper'

RSpec.describe Location do
  it 'has attributes' do
    data = {:adminArea5=>"Denver",
        :adminArea3=>"CO",
        :adminArea1=>"US",
        :latLng=>{:lat=>39.738453, :lng=>-104.984853}}

    location = Location.new(data)

    expect(location).to be_a(Location)
    expect(location.coordinates).to eq({:lat=>39.738453, :lng=>-104.984853})
    expect(location.city).to eq("Denver")
    expect(location.state).to eq("CO")
    expect(location.country).to eq("US")
  end
end
