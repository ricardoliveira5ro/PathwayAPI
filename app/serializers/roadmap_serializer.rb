class RoadmapSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id
  has_many :categories
end
