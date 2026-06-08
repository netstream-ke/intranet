
class ConversationsController < ApplicationController
  before_action :require_login

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages.includes(:user)
    @message = Message.new
  end

  def create
    user = User.find(params[:user_id])

    existing = Conversation.joins(:conversation_participants)
                           .where(conversation_participants: { user_id: [current_user.id, user.id] })
                           .group("conversations.id")
                           .having("COUNT(conversations.id) = 2")
                           .first

    if existing
      redirect_to conversation_path(existing)
      return
    end

    @conversation = Conversation.create

    @conversation.users << current_user
    @conversation.users << user

    redirect_to conversation_path(@conversation)
  end
end


