class Api::V2::BaseController < ApplicationController
  def index
    render json: {
      message: "Welcome to Pathway API",
      version: "1.0",
      documentation: "https://github.com/ricardoliveira5ro/PathwayAPI/blob/master/README.md",
      status: "Online",
      rate_limiting: "No limit. The first request may take up to 60 seconds",
      authentication: "Bearer token required for all endpoints"
    }, status: :ok
  end
end