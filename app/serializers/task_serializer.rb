class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :points, :active
end
