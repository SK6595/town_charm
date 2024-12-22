class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]
  before_action :destroy_user_check, only: [:destroy]
  
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
  
  def destroy
    @chat.destroy
    flash[:success] = "削除しました"
    redirect_back(fallback_location: root_url)
  end
  
  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.followings.include?(@user)
  end
  
  def destroy_user_check
    @chat = current_user.chats.find_by_id(params[:id])
    redirect_to root_path unless @chat
  end
end
