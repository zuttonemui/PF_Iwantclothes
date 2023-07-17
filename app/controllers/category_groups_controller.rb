class CategoryGroupsController < ApplicationController
  before_action :ensure_correct_user

  def create
    @group = CategoryGroup.new(category_group_params)
    if @group.save
      redirect_to want_clothes_path
    else
      redirect_to want_clothes_path
    end
  end

  def destroy
    @group = CategoryGroup.find(params[:id])
    @group.destroy
    redirect_to want_clothes_path
  end

  private
  def category_group_params
    params.require(:category_group).permit(:name)
  end

  def ensure_correct_user
    unless current_user.is_admin == true
      redirect_to about_path
    end
  end
end
