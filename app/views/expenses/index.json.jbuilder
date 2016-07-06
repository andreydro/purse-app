json.array!(@expenses) do |expense|
  json.extract! expense, :id, :expenses
  json.url expense_url(expense, format: :json)
end
