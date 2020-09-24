require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'validations' do
    it { should validate_presence_of(:origin) }
    it { should validate_presence_of(:destination) }
    it { should validate_presence_of(:travel_time) }
    it { should validate_presence_of(:forecast_temp) }
    it { should validate_presence_of(:forecast_description) }
    it { should belong_to(:user) }
  end
end
