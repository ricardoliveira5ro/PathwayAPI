class Api::V1::RoadmapsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    roadmaps = Roadmap.all
    render json: roadmaps, status: 200
  end

  def show
    roadmap = Roadmap.find(params[:id])
    render json: roadmap, status: :ok
  end

  def create
    roadmap = Roadmap.new(roadmap_params)
    roadmap.user_id = current_user.id

    if roadmap.save
      render json: roadmap, status: :created
    else
      render json: { errors: roadmap.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    roadmap = Roadmap.find(params[:id])

    if roadmap.user_id != current_user.id
      render json: { 
        status: { code: 403, message: "Cannot perfom this operation, roadmap created by other user" }
      }, status: :forbidden
      return
    end

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
        category_ids: []
    )
    end

    def record_not_found(error)
      model_name = error.model.constantize.model_name.human
      id = error.message[/\d+/]
      render json: { 
        status: { 
          code: 404, 
          message: "#{model_name} with ID #{id} not found"
        }
      }, status: :not_found
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
