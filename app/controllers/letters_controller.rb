class LettersController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)

    unless entries.nil?
      @room = entries.room
    else
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
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
      redirect_to user_path(current_user)
    end
  end
end