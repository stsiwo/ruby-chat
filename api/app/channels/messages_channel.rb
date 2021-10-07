class MessagesChannel < ApplicationCable::Channel
  def subscribed
    conversation = ChatRoom.find(params[:chat_room])
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
