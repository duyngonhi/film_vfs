class LikesController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user

  def show
  end

  def index
  end

  def create
    # binding.pry
    find_film params[:like_film_id]
    unless current_user.liking? @film
      # binding.pry
      current_user.like @film
    end
    @active_likes = current_user.active_likes.
      find_by like_film_id: @film.id
    redirect_back fallback_location: :back
  end

  def destroy
    # binding.pry
    @like = current_user.active_likes.find_by like_film_id: params[:id]
    unless @like.nil?
      # binding.pry
      @film = @like.like_film
      current_user.unlike @film
    end
    @active_like = current_user.active_likes.build
    redirect_back fallback_location: :back
  end

  private

  def find_film film_id
    begin
      @film = Film.find_by id: film_id
    rescue Exception
      response_to_message t("manage_films.not_found"), root_url
    end
  end
end
