class ChatsController < ApplicationController
  before_action :set_room, only: [:create, :edit, :update, :destroy]
  before_action :set_chat, only: [:edit, :update, :destroy]
  
  def create
    if UserRoom.where(user_id: current_user.id, room_id: @room.id)
      @chat = Chat.create(chat_params)
      if @chat.save
        @chat = Chat.new
        gets_all_chats
      end
    else
      flash[:alert] = 'メッセージの送信に失敗しました'
    end
  end
  
  def edit
  end
  
  def update
    if @chat.update(chat_params)
      gets_all_chats
    end
  end
  
  def destroy
    if @chat.destroy
      gets_all_chats
    end
  end
  
  private
  
  def set_room
    @room = Room.find(params[:chat][:room_id])
  end
  
  def set_chat
    @chat = Chat.find(params[:id])
  end
  
  def gets_all_chats
    @chats = @room.chats.includes(:user).order('created_at asc')
    @user_rooms = @room.user_rooms
  end
  
  def chat_params
    params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
