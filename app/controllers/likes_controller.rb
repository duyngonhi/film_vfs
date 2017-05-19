class LikesController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user
  before_action :find_film, only: [:create]
  before_action :find_like, only: [:destroy]

  def show
  end

  def index
  end

  def create
    unless current_user.liking? @film
      current_user.like @film
    end
    @active_likes = current_user.active_likes.find_by like_film_id: @film.id
    redirect_back fallback_location: :back
  end

  def destroy
    unless @like.nil?
      @film = @like.like_film
      current_user.unlike @film
    end
    @active_like = current_user.active_likes.build
    redirect_back fallback_location: :back
  end

  private

  def find_film
    @film = Film.find_by id: params[:like_film_id]
  end

  def find_like
    @like = current_user.active_likes.find_by like_film_id: params[:id]
  end
end
