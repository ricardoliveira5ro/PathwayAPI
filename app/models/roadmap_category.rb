class RoadmapCategory < ApplicationRecord
  belongs_to :roadmap
  belongs_to :category
end
