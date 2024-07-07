class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    categories = Category.all
    render json: categories, status: 200
  end

  def show
    category = Category.find_by(id: params[:id])

    if category
      render json: category, status: 200
    else
      render json: { 
        status: { code: 404, message: "Category not found" }
      }, status: :not_found
    end
  end
end