class RoadmapSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at
  has_many :categories
end
