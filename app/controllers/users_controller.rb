class UsersController < ApplicationController
  # skip_before_action(:force_user_sign_in, { :only => [:new_registration_form, :create] })
  
  def index
    @users = User.all.order({ :username => :asc })
    render({ :template => "users/index.html.erb" })
  end
  
  def new_registration_form
    render({ :template => "user_sessions/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")

    save_status = @user.save

    if save_status == true
      session.store(:user_id,  @user.id)
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_registration_form
    render({ :template => "users/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.comments_count = params.fetch("query_comments_count")
    @user.likes_count = params.fetch("query_likes_count")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "users/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end

  def create_follow_request
    sender = @current_user
    leader_id = params.fetch("query_recipient_id")
    leader = User.where({ :id => leader_id}).first
    new_request = FollowRequest.new
    new_request.recipient_id = leader
    new_request.sender_id = sender
    if leader.is_private
      new_request.status = "pending"
    else
      new_request.status = "accepted"
    end
    save_status = new_request.save

    if save_status == true
      if new_request.status == "accepted"   
        redirect_to("/users/"+leader_id)
      else
        redirect_to("/users", { :notice => "User request pending"})
      end
    else
      redirect_to("/users", { :alert => "User request failed to create successfully."})
    end
  end

  def show
    the_username = params.fetch("the_username")
    @user = User.where({ :username => the_username }).at(0)
    render({ :template => "users/show.html.erb" })
  end

  def update_with_user_id
    @user = @current_user
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    
    if @user.valid?
      @user.save
      redirect_to("/users/#{@user.username}", { :notice => "User account updated successfully."})
    else
      redirect_to("/users/#{@user.username}", { :alert => "User account not updated."})
    end
  end
  
end
