class Api::V2::RoadmapsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:update, :destroy]

  def index
    roadmaps = Roadmap.paginate(page: params[:page], per_page: params[:per_page])

    render json: roadmaps, status: :ok
  end

  def show
    roadmap = Roadmap.find(params[:id])

    render json: roadmap, status: :ok
  end

  def create
    roadmap = Roadmap.new(roadmap_params)
    roadmap.user_id = current_user.id
    roadmap.save!

    render json: roadmap, status: :created
  end

  def update
    roadmap = Roadmap.find(params[:id])
    roadmap.update!(roadmap_params)

    render json: roadmap, status: :ok
  end

  def destroy
    Roadmap.find(params[:id]).destroy!

    render json: { 
      status: { code: 200, message: "Roadmap '#{params[:id]}' successfully deleted" }
    }, status: :ok
  end



  private
    def roadmap_params
      params.require(:roadmap).permit(
        :title, 
        :description, 
        category_ids: [],
        steps_attributes: [:title, :description, :order]
      )
    end

    def check_ownership
      render json: { 
        status: { 
          code: 403, 
          message: "Cannot perform this operation, roadmap created by another user" 
        } 
      }, status: :forbidden unless Roadmap.find(params[:id]).user_id == current_user.id
    end
end
