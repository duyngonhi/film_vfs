class Admin::FilmsController < ApplicationController
  include ResponseMessage
  before_action :load_film, only: [:show, :edit, :update, :destroy]

  def index
    @films = Film.paginate page: params[:page], per_page: 10
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
    rescue Exception => e
      response_to_message t("manage_films.not_found"), admin_films_url
    end
  end
end
