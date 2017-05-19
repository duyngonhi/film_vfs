class RelationshipsController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user
  before_action :find_user, only: [:create]
  before_action :find_relationship, only: [:destroy]

  def show
  end

  def index
  end

  def create
    unless current_user.following? @user
      current_user.follow @user
    end
    @active_relationship = current_user.active_relationships.find_by followed_id: @user.id
    redirect_back fallback_location: :back
  end

  def destroy
    unless @relationship.nil?
      @user = @relationship.followed
      current_user.unfollow @user
      @active_relationship = current_user.active_relationships.build
    end
    redirect_back fallback_location: :back
  end

  private

  def find_user
    @user = User.find_by id: params[:followed_id]
  end

  def find_relationship
    @relationship = Relationship.find_by id: params[:id]
  end
end
