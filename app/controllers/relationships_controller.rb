class RelationshipsController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user

  def show
  end

  def index
  end

  def create
    find_user params[:followed_id]
    unless current_user.following? @user
      current_user.follow @user
    end
    @active_relationship = current_user.active_relationships.
      find_by followed_id: @user.id
    redirect_back fallback_location: :back
  end

  def destroy
    @relationship = Relationship.find_by id: params[:id]
    unless @relationship.nil?
      @user = @relationship.followed
      current_user.unfollow @user
      @active_relationship = current_user.active_relationships.build
    end
    redirect_back fallback_location: :back
  end

  private

  def find_user user_id
    begin
      @user = User.find_by id: user_id
    rescue Exception
      response_to_message t("activity.user_nill"), root_url
    end
  end
end
