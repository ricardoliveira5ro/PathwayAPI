class Roadmap < ApplicationRecord
  has_many :roadmap_categories, dependent: :destroy
  has_many :categories, through: :roadmap_categories
  has_many :steps, -> { order(:order) }, dependent: :destroy

  validates :title, :description, :categories, presence: true
  
  accepts_nested_attributes_for :steps
end
