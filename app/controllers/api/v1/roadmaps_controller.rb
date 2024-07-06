class Api::V1::RoadmapsController < ApplicationController
  before_action :authenticate_user!

  def index
    roadmaps = Roadmap.where(user_id: [current_user.id, nil])
    render json: roadmaps, status: 200
  end

  def show
    roadmap = Roadmap.find_by(id: params[:id])

    if roadmap
      render json: roadmap, status: 200
    else
      render json: { 
        status: { code: 404, message: "Roadmap not found" }
      }, status: :not_found
    end
  end

  def create
    params[:roadmap][:category_ids].each do |category_id|
      if !Category.exists?(category_id)
        render json: { 
          status: { code: 404, message: "Category #{category_id} not found" }
        }, status: :not_found
        return
      end
    end

    roadmap = Roadmap.new(roadmap_params)
    roadmap.user_id = current_user.id

    if roadmap.save
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
