class ChatRoomMember < ApplicationRecord
  self.primary_keys = :user_id, :chat_room_id
  belongs_to :user
  belongs_to :chat_room
end
