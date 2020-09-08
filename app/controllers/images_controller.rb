class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    user  = current_user
    image = Image.new(params.permit(:title, :description, :location, :image))
    image.user_id = current_user.id

    if image.save!
      if params[:tags]
        for tag_name in params[:tags] do
          if (tag = Tag.find_by(tag_title: tag_name)) != nil
            tag_relation = TagRelation.create!(tag_id: tag.id, image_id: image.id)
          else
            tag = Tag.create!(tag_title: tag_name)
            tag_relation = TagRelation.create!(tag_id: tag.id, image_id: image.id)
          end
        end
      end
      render json: "Success, image id: #{image.id}"
    end
  end

  def destroy
    user = current_user
    if user.id == image.user_id
      render json: "Cannot delete another users photo"
    end
    image = Image.find_by(params.require(:image).permit(:title))
    if image.destroy!
      render json: "Success, image destroyed"
    end
  end

  def show
    if (image = Image.find_by(params.require(:image).permit(:title))) != nil
      render json: Rails.application.routes.url_helpers.rails_blob_path(image.image, only_path: true)
    else
      render json: "This image does not exist"
    end
  end

  def index
    if (images = current_user.images) != nil
      render json: images
    else
      render json: "You have no images"
    end
  end

  def tag_search
    if (tag = Tag.find_by(tag_title: params[:tag])) != nil
      render json: tag.images
    else
      render json: "There is no tag with this name"
    end
  end

end
