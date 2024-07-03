class Api::V1::RoadmapsController < ApplicationController
  before_action :authenticate_user!

  def index
    roadmaps = Roadmap.all
    render json: roadmaps, status: 200
  end

  def show
    roadmap = Roadmap.find_by(id: params[:id])

    if roadmap
      render json: roadmap, status: 200
    else
      render json: { error: "Roadmap not found" }
    end
  end

  def create
    roadmap = Roadmap.new(roadmap_params)
    roadmap.user_id = current_user.id

    if params[:roadmap][:category_ids].present? && roadmap.save 
      roadmap.category_ids = params[:roadmap][:category_ids]

      render json: roadmap, status: :created
    else
      render json: { errors: roadmap.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def roadmap_params
      params.require(:roadmap).permit(
        :title, 
        :description, 
        category_ids: []
    )
    end
end
