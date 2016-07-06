json.array!(@incomes) do |income|
  json.extract! income, :id, :incomes
  json.url income_url(income, format: :json)
end
