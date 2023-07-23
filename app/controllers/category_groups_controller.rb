class CategoryGroupsController < ApplicationController
  def want_item
    @categories = Category.all
    @group = CategoryGroup.find(params[:id])
    categories = @group.categories.pluck(:id)
    @want_items = WantItem.where(category_id: categories).page(params[:page]).per(10).order(created_at: :desc)
  end

  def recommend
    @group = CategoryGroup.find(params[:id])
    categories = @group.categories.pluck(:id)
    @recommends = Recommend.where(category_id: categories).page(params[:page]).per(8).order(created_at: :desc)
  end

  def create
    @group = CategoryGroup.new(category_group_params)
    if @group.save
      redirect_to want_items_path
    else
      redirect_to want_items_path
    end
  end

  def destroy
    @group = CategoryGroup.find(params[:id])
    @group.destroy
    redirect_to want_items_path
  end

  private
  def category_group_params
    params.require(:category_group).permit(:name)
  end
end
