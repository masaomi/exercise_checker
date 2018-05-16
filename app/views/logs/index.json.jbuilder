json.array!(@logs) do |log|
  json.extract! log, :id, :user, :problem
  json.url log_url(log, format: :json)
end
