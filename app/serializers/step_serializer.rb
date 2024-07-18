class StepSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :order, :completed
  
  def completed
    Tracker.find_by(user_id: current_user.id, step_id: object.id)&.completed || false
  end
end
