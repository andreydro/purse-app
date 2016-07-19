class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:show, :edit, :update, :destroy]
  before_action :require_editor, only:[:show, :edit]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = current_user.expenses.order('date desc')
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @categories = Category.categories_names
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    if params[:expense][:categories].present?
      @category = current_user.build_category_if_not_exists(params[:expense][:categories])

      @expense = current_user.expenses.build(expense_params)
      @expense.category = @category

      if @expense.save
        redirect_to expense_path
      else
        flash[:alert] = "Fill in all fields please"
        render :new
      end
    else
      flash[:alert] = "create a new categories first"
      redirect_to new_category_path
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])
    @category = current_user.build_category_if_not_exists(params[:expense][:categories][:name])
    @expense.category = @category

    if @expense.update(expense_params)
      redirect_to expense_path
    else
      flash[:alert] = "Fill in all fields please"
      render :edit
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params["id"])
    @expense.destroy

    redirect_to expense_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:sum, :date)
    end
end
