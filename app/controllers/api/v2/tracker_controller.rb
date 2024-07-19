class Api::V2::TrackerController < ApplicationController
  before_action :authenticate_user!

  # create or update tracking
  def create
    tracker = Tracker.find_by(user_id: current_user.id, step_id: params[:step_id])

    if tracker
      tracker.update!(tracker_params)
    else
      tracker = Tracker.new(tracker_params)
      tracker.user_id = current_user.id
      tracker.step_id = params[:step_id]
      tracker.save!
    end

    render json: tracker, status: :created
  end


  private

  def tracker_params
    params.require(:tracker).permit(:completed)
  end
end