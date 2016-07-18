class CategoryController < ApplicationController

  def index
    @categories = current_user.categories.all
  end

  def create
    @category = current_user.build_category_if_not_exists(category_params[:name])

    if @category.save
      redirect_to categories_path
    else
      flash[:alert] = "Enter category name please"
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path
    else
      flash[:alert] = "Category name can't be blank"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
