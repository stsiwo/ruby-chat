class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  belongs_to :content_type
end
