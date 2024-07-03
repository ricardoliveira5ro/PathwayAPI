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

  private
    def roadmap_params
      params.require(:roadmap).permit(
        :title, 
        :description, 
        category_ids: []
    )
    end
end
