class CreateRoadmapCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :roadmap_categories do |t|
      t.references :roadmap, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
