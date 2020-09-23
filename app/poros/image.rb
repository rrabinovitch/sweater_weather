class Image
  def initialize(img_data, location)
    @id = nil
    @location = location
    @image_url = img_data[:photos][0][:url]
    @credit = credit(img_data)
  end

  def credit(img_data)
    { source: "pexels.com",
      photographer: img_data[:photos][0][:photographer] }
  end
end
