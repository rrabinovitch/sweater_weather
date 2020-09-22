class Restaurant
  attr_reader :name, :address
  
  def initialize(restaurant_data)
    @name = restaurant_data[:restaurants].first[:restaurant][:name]
    @address = restaurant_data[:restaurants].first[:restaurant][:location][:address]
  end
end
