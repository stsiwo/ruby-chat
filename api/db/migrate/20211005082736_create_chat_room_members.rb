class CreateChatRoomMembers < ActiveRecord::Migration[6.1]
  def change
    create_table(:chat_room_members, id: false) do |t|
      t.timestamp :last_online_at
      t.boolean :is_owner
      t.timestamps
      t.references :user, type: :string, limit: 11, null: false, foregin_key: true
      t.references :chat_room, type: :string, limit: 11, null: false, foregin_key: true
    end
    add_foreign_key :chat_room_members, :users, column: :user_id, primary_key: 'id', on_delete: :cascade, on_update: :cascade
    add_foreign_key :chat_room_members, :chat_rooms, column: :chat_room_id, primary_key: 'id', on_delete: :cascade, on_update: :cascade
    execute 'ALTER TABLE chat_room_members ADD PRIMARY KEY (user_id, chat_room_id);'
  end
end
