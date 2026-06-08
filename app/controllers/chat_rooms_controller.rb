class ChatRoomsController < ApplicationController
  before_action :require_login
  before_action :set_chat_room, only: [:show]

def index
  @chat_rooms = current_user.chat_rooms
end


def new_chat
  @users = User.where.not(id: current_user.id)
end

def show
  @chat_room = ChatRoom.find(params[:id])

  # Mark unread messages from other users as read
  @chat_room.chat_messages
            .where.not(user_id: current_user.id)
            .where(read: false)
            .update_all(read: true)

  @messages = @chat_room.chat_messages.includes(:user)
  @chat_message = ChatMessage.new
end

def create
  other_user = User.find(params[:user_id])

  other_user = User.find(params[:user_id])

ChatNotification.create!(
  user: other_user,
  actor_id: current_user.id,
  message: "#{current_user.name} started a chat with you",
  read: false
)

  @chat_room = ChatRoom.joins(:chat_room_users)
                       .where(chat_room_users: { user_id: [current_user.id, other_user.id] })
                       .group("chat_rooms.id")
                       .having("COUNT(chat_room_users.user_id) = 2")
                       .first

  unless @chat_room
    @chat_room = ChatRoom.create!
    @chat_room.users << current_user
    @chat_room.users << other_user
  end

  redirect_to chat_room_path(@chat_room)
end



  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
