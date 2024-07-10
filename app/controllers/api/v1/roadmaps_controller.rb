class Api::V1::RoadmapsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

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

    def record_not_found(error)
      render json: { 
        status: { 
          code: 404, 
          message: error.message
        }
      }, status: :not_found
    end

    def record_invalid(error)
      render json: { 
        status: { 
          code: 422, 
          message: error.record.errors.full_messages
        }
      }, status: :unprocessable_entity
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
