class Api::V2::TrackerController < ApplicationController
  before_action :authenticate_user!

  def create
    tracker = Tracker.new(tracker_params)
    tracker.user_id = current_user.id
    tracker.step_id = params[:step_id]
    tracker.save!

    render json: tracker, status: :created
  end

  def update
    tracker = Tracker.find_by(user_id: current_user.id, step_id: params[:step_id])
    tracker.update!(tracker_params)

    render json: tracker, status: :ok
  end


  private

  def tracker_params
    params.require(:tracker).permit(:completed)
  end
end