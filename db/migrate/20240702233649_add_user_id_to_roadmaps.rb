class AddUserIdToRoadmaps < ActiveRecord::Migration[7.1]
  def change
    add_reference :roadmaps, :user, foreign_key: true
  end
end
