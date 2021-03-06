class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to @user
    end
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_to @user
    end
  end

  def following
     user = User.find(params[:user_id])
     @users = user.followings
  end

  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

end