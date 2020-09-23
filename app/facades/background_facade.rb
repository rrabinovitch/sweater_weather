class BackgroundFacade
  def initialize
    @pexel_service ||= PexelService.new
  end

  def get_location_img(location)
    img_data = @pexel_service.img_by_location(location)
    Image.new(img_data, location)
  end
end
