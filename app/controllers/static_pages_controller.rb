class StaticPagesController < ApplicationController
  before_action :load_film, only: [:show]

  def home
    @search = Film.ransack params[:q]
    @films = @search.result
  end

  def show
  end

  def load_film
    begin
      @film = Film.find params[:id]
    rescue Exception
      response_to_message t("manage_films.not_found"), root_url
    end
  end
end
