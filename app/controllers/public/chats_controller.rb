class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]
  
  def show
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
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  
  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.followings.include?(@user)
  end
end
