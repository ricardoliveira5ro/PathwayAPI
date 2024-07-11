class Api::V1::StepsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: [:create]

  def show
    step = Step.find(params[:id])

    render json: step, status: :ok
  end

  def index
    roadmap = Roadmap.find(params[:roadmap_id])
    steps = roadmap.steps.order(:order)

    render json: steps, status: :ok
  end

  def create
    step = Step.new(step_params)
    step.roadmap_id = params[:roadmap_id]
    step.save!

    render json: step, status: :created
  end

  def update
    step = Step.find(params[:id])
    step.update!(step_params)

    render json: step, status: :ok
  end

  def destroy
    Step.find(params[:id]).destroy!

    render json: { 
      status: { code: 200, message: "Roadmap '#{params[:id]}' successfully deleted" }
    }, status: :ok
  end



  private

  def step_params
    params.require(:step).permit(
      :title,
      :description,
      :order
    )
  end

  def check_ownership
    render json: { 
      status: { 
        code: 403, 
        message: "Cannot perform this operation, roadmap created by another user" 
      } 
    }, status: :forbidden unless Roadmap.find(params[:roadmap_id]).user_id == current_user.id
  end
end