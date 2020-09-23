class Image
  attr_reader :id, :location, :image_url, :credit

  def initialize(img_data, location)
    @id = nil
    @location = location
    @image_url = img_data[:url]
    @credit = { source: "pexels.com",
                photographer: img_data[:photographer] }
  end
end
