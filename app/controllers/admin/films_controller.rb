class Admin::FilmsController < ApplicationController
  include ResponseMessage, ExportCsv
  before_action :checking_logged_user
  before_action :checking_admin, only: [:index, :edit, :update, :destroy]
  before_action :load_film, only: [:show, :edit, :update, :destroy]

  def index
    @search = Film.ransack params[:q]
    @films = @search.result.paginate page: params[:page],
      per_page: Settings.paging
    respond_to_csv @films
  end

  def show
  end

  def edit
    @categories = Category.all
  end

  def update
    if @film.update film_params
      response_to_message t("manage_films.message_apdate_sucess"),
        admin_films_url
    else
      response_to_message t("manage_films.message_apdate_notsucess"),
        admin_films_url
    end
  end

  def new
    @film = Film.new
    @categories = Category.all
  end

  def create
    @film = Film.new film_params
    if @film.save
      response_to_message t("manage_films.create_sucess"), admin_films_url
    else
      response_message_errors @film
    end
  end

  def destroy
    if @film.destroy
      response_to_message t("manage_films.deleted"), admin_films_url
    else
      response_to_message t("manage_films.not_deleted"), admin_films_url
    end
  end

  private

  def film_params
    params.require(:film).permit :name_film, :year_screen, :picture_film,
      :link_trailer, :category_id
  end

  def load_film
    begin
      @film = Film.find params[:id]
    rescue Exception
      response_to_message t("manage_films.not_found"), admin_films_url
    end
  end
end
