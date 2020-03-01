class PhotosController < ApplicationController
  def index
    array_of_public_user_ids = User.where({:is_private => FALSE }).pluck(:id)
    @photos = Photo.where({ :owner_id => array_of_public_user_ids}).order({:created_at => :desc })
    render({ :template => "photos/photos.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)
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

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def comment_photo
    comment = Comment.new
    body = params.fetch("query_body")
    author_id = @current_user.id
    photo_id = params.fetch("query_photo_id") 
    comment.body = body
    comment.author_id = author_id
    comment.photo_id = photo_id
    comment.save
    photo = Photo.where({:id => photo_id}).first
    photo.comments_count = photo.comments_count + 1
    photo.save
    redirect_to("/photos/#{photo_id}")
  end

  def like_photo
    like = Like.new
    like.fan_id = @current_user.id
    photo_id = params.fetch("query_photo_id")
    like.photo_id = photo_id
    like.save
    photo = Photo.where({:id => photo_id}).first
    photo.likes_count = photo.likes_count + 1
    photo.save
    redirect_to("/photos/#{photo_id}")
  end

  def unlike_photo
    the_id = params.fetch("like_id")
    like = Like.where({:id => the_id}).first
    photo_id = like.photo_id
    photo = Photo.where({:id => photo_id}).first
    photo.likes_count = photo.likes_count - 1
    photo.save
    like.destroy
    redirect_to("/photos/#{photo_id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)
    @photo.destroy
    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
