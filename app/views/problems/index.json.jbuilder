json.array!(@problems) do |problem|
  json.extract! problem, :id, :name, :question
  json.url problem_url(problem, format: :json)
end
