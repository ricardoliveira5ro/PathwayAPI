class CreateTrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :trackers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
