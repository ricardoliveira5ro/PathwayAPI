class RemoveCategoryFromRoadmaps < ActiveRecord::Migration[7.1]
  def change
    remove_column :roadmaps, :category, :string
  end
end
