class StaticPagesController < ApplicationController
  before_action :load_film, only: [:show, :update]

  def home
    @search = Film.ransack params[:q]
    @films = @search.result
    if current_user.present?
      @active_like = current_user.active_likes.build
    end
  end

  def show
  end

  def update
    if @film.update film_params
      redirect_back fallback_location: :back
    else
      response_to_message t("manage_films.message_apdate_notsucess"),
        root_url
    end
  end

  def film_params
    params.require(:film).permit :count_like
  end

  def load_film
    begin
      @film = Film.find params[:id]
    rescue Exception
      response_to_message t("manage_films.not_found"), root_url
    end
  end
end
