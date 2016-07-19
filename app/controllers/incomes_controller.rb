class IncomesController < ApplicationController
  before_action :require_user, only: [:show, :edit, :update, :destroy]
  before_action :require_editor, only:[:show, :edit]

  def index
    @incomes = current_user.incomes.order('date desc')
  end

  def new
    @income = Income.new
    @categories = Category.categories_names
  end

  def create
    if params[:income][:category].present?
      @category = current_user.build_category_if_not_exists(params[:income][:category])

      @income = current_user.incomes.build(income_params)
      @income.category = @category

      if @income.save
        redirect_to incomes_path
      else
        flash[:alert] = "Fill in all fields please"
        render :new
      end
    else
      flash[:alert] = "Create a new category first"
      redirect_to new_category_path
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    redirect_to incomes_path
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @income = Income.find(params[:id])
    @category = current_user.build_category_if_not_exists(params[:income][:category][:name])
    @income.category = @category

    if @income.update(income_params)
      redirect_to incomes_path
    else
      flash[:alert] = "Fill in all fields please"
      render :edit
    end
  end

  private

  def income_params
    params.require(:income).permit(:sum, :date)
  end
end
