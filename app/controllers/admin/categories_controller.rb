class Admin::CategoriesController < ApplicationController
  include ResponseMessage
  before_action :load_catagory, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page], per_page: 10
  end

  def show
  end

  def edit
  end

  def update
    if @category.update category_params
      response_to_message t("category.message_apdate_sucess"),
        admin_categories_url
    else
      response_to_message t("category.message_apdate_notsucess"),
        admin_categories_url
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      response_to_message t("category.create_sucess"), admin_categories_url
    else
      response_to_message t("category.create_notsucess"), admin_categories_url
    end
  end

  def destroy
    if @category.destroy
      response_to_message t("category.deleted"), admin_categories_url
    else
      response_to_message t("category.not_deleted"), admin_categories_url
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_catagory
    begin
      @category = Category.find params[:id]
    rescue Exception => e
      response_to_message t("category.not_found"), admin_categories_url
    end
  end
end
