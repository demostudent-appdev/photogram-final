class UsersController < ApplicationController
  def index
    @users = User.all.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @user = User.where({:id => the_id }).at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    @user = User.new
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.email = params.fetch("query_email")
    @user.password_digest = params.fetch("query_password_digest")
    @user.comments_count = params.fetch("query_comments_count")
    @user.likes_count = params.fetch("query_likes_count")

    if @user.valid?
      @user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :notice => "User failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @user = User.where({ :id => the_id }).at(0)

    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.email = params.fetch("query_email")
    @user.password_digest = params.fetch("query_password_digest")
    @user.comments_count = params.fetch("query_comments_count")
    @user.likes_count = params.fetch("query_likes_count")

    if @user.valid?
      @user.save
      redirect_to("/users/#{@user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{@user.id}", { :alert => "User failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @user = User.where({ :id => the_id }).at(0)

    @user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end
end
