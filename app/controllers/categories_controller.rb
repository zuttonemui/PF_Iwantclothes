class CategoriesController < ApplicationController
  before_action :ensure_correct_user

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to want_clothes_path
    else
      redirect_to want_clothes_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to want_clothes_path
  end

  private
  def category_params
    params.require(:category).permit(:category_group_id, :name)
  end

  def ensure_correct_user
    unless current_user.is_admin == true
      redirect_to about_path
    end
  end
end
