class CreateRoadmaps < ActiveRecord::Migration[7.1]
  def change
    create_table :roadmaps do |t|
      t.string :title
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
