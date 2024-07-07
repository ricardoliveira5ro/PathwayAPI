class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.string :title
      t.string :description
      t.references :roadmap, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
