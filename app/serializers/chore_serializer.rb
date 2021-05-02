class ChoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :child_id, :due_on

  attribute :task do |object|
    ChoreTaskSerializer.new(object.task)
  end

  attribute :completed do |object|
    object.status
  end
end
