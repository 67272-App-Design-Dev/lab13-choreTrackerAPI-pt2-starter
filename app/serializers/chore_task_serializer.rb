class ChoreTaskSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name
end