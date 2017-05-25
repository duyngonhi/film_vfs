class Admin::UsersController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user
  before_action :checking_admin, only: [:index, :edit, :update, :destroy]
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @search = User.ransack params[:q]
    @users = @search.result.paginate page: params[:page],
      per_page: Settings.paging
  end

  def show
  end

  def edit
  end

  def destroy
    if @user.destroy
      response_to_message t("manage_user.deleted"), admin_users_url
    else
      response_to_message t("manage_user.not_deleted"), admin_users_url
    end
  end

  def update
    if @user.update user_params
      response_to_message t("manage_user.admin_update_sucess"), admin_users_url
    else
      response_to_message t("manage_user.admin_update_not_sucess"), admin_users_url
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
