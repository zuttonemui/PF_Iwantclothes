class GenresController < ApplicationController
  before_action :ensure_correct_user

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to want_clothes_path
    else
      redirect_to want_clothes_path
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to want_clothes_path
  end

  private
  def genre_params
    params.require(:genre).permit(:category, :name)
  end

  def ensure_correct_user
    unless current_user.is_admin == true
      redirect_to about_path
    end
  end
end
