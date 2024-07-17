class Api::V2::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    categories = Category.paginate(page: params[:page], per_page: params[:per_page])

    render json: categories, status: :ok
  end

  def show
    category = Category.find_by(id: params[:id])

    render json: category, status: :ok
  end
end