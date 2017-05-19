class Admin::ScriptsController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user
  before_action :checking_admin, only: [:index, :edit, :update, :destroy]
  before_action :load_script, only: [:show, :edit, :update, :destroy]

  def index
    @search = Script.ransack params[:q]
    @scripts = @search.result.paginate page: params[:page],
      per_page: Settings.paging
  end

  def show
  end

  def edit
  end

  def update
    if @script.update script_params
      response_to_message t("activity.message_approve"), admin_scripts_url
    else
      response_to_message t("script_film.message_fail"), admin_scripts_url
    end
  end

  private

  def script_params
    params.require(:script).permit :status
  end

  def load_script
    begin
      @script = Script.find params[:id]
    rescue Exception
      response_to_message t("script_film.not_found"), admin_scripts_url
    end
  end

end
