class ReportsController < ApplicationController

  def report
    start_date  = params[:start_date].presence || 1.year.ago
    end_date    = params[:end_date].presence   || Time.now
    category_id = params[:category]

    @incomes = current_user.filter_incomes(category_id, start_date, end_date)
    @expenses = current_user.filter_expenses(category_id, start_date, end_date)

    @incomes_sum = @incomes.sum(:sum)
    @expenses_sum = @expenses.sum(:sum)

    @balance = @incomes_sum - @expenses_sum
    @report_data = (@incomes + @expenses).sort_by(&:date).reverse!
  end

end
