class PhotosController < ApplicationController
  def index
    array_of_public_user_ids = User.where({:is_private => FALSE }).pluck(:id)
    @photos = Photo.where({ :owner_id => array_of_public_user_ids}).order({:created_at => :desc })
    # Photo.all.order({:created_at => :desc })
    render({ :template => "photos/photos.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @photo = Photo.where({:id => the_id }).at(0)
    render({ :template => "photos/show.html.erb" })
  end

  def create
    @photo = Photo.new
    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("query_image")
    @photo.owner_id = @current_user.id
    @photo.comments_count = 0
    @photo.likes_count = 0

    if @photo.valid?
      @photo.save
      redirect_to("/photos", { :notice => "Photo uploaded successfully." })
    else
      redirect_to("/photos", { :notice => "Photo failed to be uploaded." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("query_image")
    @photo.owner_id = params.fetch("query_owner_id")
    @photo.comments_count = params.fetch("query_comments_count")
    @photo.likes_count = params.fetch("query_likes_count")

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
