class CategoriesController < ApplicationController
  def want_item
    @categories = Category.all
    @category = Category.find(params[:id])
    @want_items = @category.want_items.page(params[:page]).per(10).order(created_at: :desc)
  end

  def recommend
    @category = Category.find(params[:id])
    @recommends = Recommend.where(category_id: @category.id).page(params[:page]).per(8).order(created_at: :desc)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to want_items_path
    else
      redirect_to want_items_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to want_items_path
  end

  private
  def category_params
    params.require(:category).permit(:category_group_id, :name)
  end
end
