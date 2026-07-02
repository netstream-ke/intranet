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
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end