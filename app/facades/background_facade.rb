class BackgroundFacade
  def self.get_location_img(location)
    img_data = PexelsService.img_by_location(location)
    Image.new(img_data, location)
  end
end
