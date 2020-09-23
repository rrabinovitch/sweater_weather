require 'rails_helper'

RSpec.describe GeoService do
  it 'can return location data' do

    geo_service = GeoService.new
    results = geo_service.location_data('Denver, CO')

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


# {:street=>"",
#  :adminArea6=>"",
#  :adminArea6Type=>"Neighborhood",
#  :adminArea5=>"Denver",
#  :adminArea5Type=>"City",
#  :adminArea4=>"Denver County",
#  :adminArea4Type=>"County",
#  :adminArea3=>"CO",
#  :adminArea3Type=>"State",
#  :adminArea1=>"US",
#  :adminArea1Type=>"Country",
#  :postalCode=>"",
#  :geocodeQualityCode=>"A5XAX",
#  :geocodeQuality=>"CITY",
#  :dragPoint=>false,
#  :sideOfStreet=>"N",
#  :linkId=>"282041090",
#  :unknownInput=>"",
#  :type=>"s",
#  :latLng=>{:lat=>39.738453, :lng=>-104.984853},
#  :displayLatLng=>{:lat=>39.738453, :lng=>-104.984853},
#  :mapUrl=>
#   "http://www.mapquestapi.com/staticmap/v5/map?key=CFuNj6G9qOkiemQqOgTbbunI9lxJi73K&type=map&size=225,160&locations=39.738453,-104.984853|marker-sm-50318A-1&scalebar=true&zoom=12&rand=-757101481"}
