class MessagesController < ApplicationController
  before_action :require_login

  def create
    @conversation = current_user.conversations.find(params[:conversation_id])

    @message = @conversation.messages.build(
      body: params[:message][:body],
      user: current_user
    )

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      @messages = @conversation.messages
      render "conversations/show"
    end
  end

    chat_room = ChatRoom.find(params[:chat_room_id])

    message = chat_room.messages.new(message_params)
    message.user = current_user

    message.save

    redirect_to chat_room_path(chat_room)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end


end
