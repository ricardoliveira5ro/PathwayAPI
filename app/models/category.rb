class Category < ApplicationRecord
  has_many :roadmap_categories, dependent: :destroy
  has_many :roadmaps, through: :roadmap_categories

  validates :name, presence: true
end
