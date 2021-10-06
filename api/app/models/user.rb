class User < ApplicationRecord
  belongs_to :user_type
  # when the owner is deleted, what should we do about the chat rooms that the owner owns? delete the room or delete the
  # owner priviledge to another member.
  has_many :chat_rooms, foreign_key: 'owner_id', class_name: 'ChatRoom', dependent: :destroy
end
