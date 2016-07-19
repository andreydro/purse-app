class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:show, :edit, :update, :destroy]
  before_action :require_editor, only:[:show, :edit]

  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = current_user.incomes.order('date desc')
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = Income.new
    @categories = Category.categories_names
  end

  # GET /incomes/1/edit
  def edit
    @income = Income.find(params[:id])
  end

  # POST /incomes
  # POST /incomes.json
  def create
    if params[:income][:categories].present?
      @category = current_user.build_category_if_not_exists(params[:income][:categories])

      @income = current_user.incomes.build(income_params)
      @income.category = @category

      if @income.save
        redirect_to income_path

      else
        flash[:alert] = "Fill in all fields please"
        render :new
      end
    else
      flash[:alert] = "Create a new categories first"
      redirect_to new_category_path
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update
    @income = Income.find(params[:id])
    @category = current_user.build_category_if_not_exists(params[:income][:categories][:name])
    @income.category = @category

    if @income.update(income_params)
      redirect_to income_path
    else
      flash[:alert] = "Fill in all fields please"
      render :edit
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income = Income.find(params[:id])
    @income.destroy

    redirect_to income_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def income_params
      params.require(:income).permit(:sum, :date)
    end
end
