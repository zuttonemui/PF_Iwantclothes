class LettersController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @letters = @room.letters
    @letter = Letter.new(room_id: @room.id)
  end

  def create
    @letter = current_user.letters.new(letter_params)
    render :validater unless @letter.save
  end

  private
  def letter_params
    params.require(:letter).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
end