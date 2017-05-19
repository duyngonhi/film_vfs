class UsersController < ApplicationController
  include ResponseMessage
  before_action :load_user, only: [:show, :edit, :update]

  def show
    if current_user.active_relationships.find_by(followed: @user.id).nil?
      @active_relationship = current_user.active_relationships.build
    else
      @active_relationship = current_user.active_relationships
        .find_by(followed_id: @user.id)
    end
    @activities = @user.activities.paginate page: params[:page],
      per_page: Settings.paging
  end

  def edit
  end

  def update
    if @user.update user_params
      response_to_message t("manage_user.admin_update_sucess"),
        user_url(@user.id)
    else
      response_to_message t("manage_user.admin_update_not_sucess"),
        user_url(@user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :birthday, :address, :phone,
      :email, :role)
  end

  def load_user
    begin
      @user = User.find(params[:id])
    rescue Exception
      response_to_message t("manage_user.not_found"), root_url
    end
  end
end
