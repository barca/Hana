json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :name, :max_occupancy, :details
  json.url classroom_url(classroom, format: :json)
end
