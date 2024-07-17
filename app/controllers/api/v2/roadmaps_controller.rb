class Api::V2::RoadmapsController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: Pagination
    roadmaps = Roadmap.all

    render json: roadmaps, status: :ok
  end
end
