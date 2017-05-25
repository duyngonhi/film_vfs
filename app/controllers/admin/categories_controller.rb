class Admin::CategoriesController < ApplicationController
  include ResponseMessage
  before_action :checking_logged_user
  before_action :checking_admin, only: [:index, :edit, :update, :destroy]
  before_action :load_catagory, only: [:edit, :update, :destroy]

  def index
    @search = Category.ransack params[:q]
    @categories = @search.result.paginate page: params[:page],
      per_page: Settings.paging
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
    rescue Exception
      response_to_message t("category.not_found"), admin_categories_url
    end
  end
end
