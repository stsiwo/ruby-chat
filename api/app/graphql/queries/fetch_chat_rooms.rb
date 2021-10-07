module Queries
  class FetchChatRooms < Queries::BaseQuery
    type [Types::ChatRoomType], null: false
    argument :id, ID, required: true

    def resolve(id:)
      ChatRoom.where(id: id).order(created_at: :desc)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Chat Room does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
