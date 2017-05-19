class ScriptsController < ApplicationController
  include ResponseMessage
  before_action :load_script, only: [:show, :edit, :update, :destroy]

  def index
    @scripts = current_user.scripts
  end

  def show
  end

  def edit
  end

  def update
    if @script.update script_params
      response_to_message t("script_film.message_apdate_sucess"), scripts_url
    else
      response_to_message t("script_film.message_apdate_notsucess"), scripts_url
    end
  end

  def new
    @script = current_user.scripts.build
  end

  def create
    @script = current_user.scripts.build script_params
    if @script.save
      response_to_message t("script_film.create_sucess"), scripts_url
    else
      response_message_errors @script
    end
  end

  def destroy
    if @script.destroy
      response_to_message t("script_film.deleted"), scripts_url
    else
      response_to_message t("script_film.not_deleted"), scripts_url
    end
  end

  private

  def script_params
    params.require(:script).permit :title, :content
  end

  def load_script
    begin
      @script = Script.find params[:id]
    rescue Exception => e
      response_to_message t("script_film.not_found"), scripts_url
    end
  end
end
