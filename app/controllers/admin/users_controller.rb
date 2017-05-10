class Admin::UsersController < ApplicationController
  include UserController
  before_action :load_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def destroy
    if @user.destroy
      response_to_message t("manage_user.deleted"), admin_users_url
    else
      response_to_message t("manage_user.not_deleted"), admin_users_url
    end
  end

  private

  def load_user
    begin
      @user = User.find(params[:id])
    rescue Exception => e
      response_to_message t("manage_user.not_found"), root_url
    end
  end
end
