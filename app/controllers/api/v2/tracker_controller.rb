class Api::V2::TrackerController < ApplicationController
  before_action :authenticate_user!

  def create
    tracker = Tracker.new(tracker_params)
    tracker.user_id = current_user.id
    tracker.step_id = params[:step_id]
    tracker.save!

    render json: tracker, status: :created
  end



  private

  def tracker_params
    params.require(:tracker).permit(:completed)
  end
end