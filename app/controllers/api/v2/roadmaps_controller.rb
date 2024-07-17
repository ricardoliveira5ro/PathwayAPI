class Api::V2::RoadmapsController < ApplicationController
  before_action :authenticate_user!

  def index
    roadmaps = Roadmap.paginate(page: params[:page], per_page: params[:per_page])

    render json: roadmaps, status: :ok
  end
end
