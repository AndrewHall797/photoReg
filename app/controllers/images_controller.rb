class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    image = Image.new(params.require(:image).permit(:title, :description, :location, :image))
    if image.save
      render json: "Success, image created"
    else
      render json: "Failure, new use not created"
    end
  end

end
