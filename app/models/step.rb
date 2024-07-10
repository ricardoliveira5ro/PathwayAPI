class Step < ApplicationRecord
  belongs_to :roadmap

  validates :title, :description, :order, presence: true
end
