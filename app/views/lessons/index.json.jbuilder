json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :instructor, :grade_level, :starts_at, :ends_at, :location, :max_enrollment, :description
  json.url lesson_url(lesson, format: :json)
end
