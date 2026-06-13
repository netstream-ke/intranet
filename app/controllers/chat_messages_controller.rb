class ChatMessagesController < ApplicationController
  before_action :require_login

def create
  @chat_room = ChatRoom.find(params[:chat_room_id])

  @chat_message = @chat_room.chat_messages.create!(
    user: current_user,
    body: params[:chat_message][:body],
    read: false
  )

  redirect_to chat_room_path(@chat_room)
end


  private

  def message_params
    params.require(:chat_message).permit(:body)
  end
end
