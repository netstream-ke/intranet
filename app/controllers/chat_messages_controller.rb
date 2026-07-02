class ChatMessagesController < ApplicationController
  before_action :require_login

  def create
    chat_room = ChatRoom.find(params[:chat_room_id])

    message = chat_room.messages.new(message_params)
    message.user = current_user

    if message.save
      redirect_to chat_room_path(chat_room)
    else
      redirect_to chat_room_path(chat_room), alert: "Message could not be sent."
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
