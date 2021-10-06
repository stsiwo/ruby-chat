class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table(:messages, id: false) do |t|
      t.string :id, primary_key: true
      t.text :content, null: false
      t.string :background_image_path
      t.timestamps

      t.references :user, type: :string, limit: 11, null: false, foregin_key: true
      t.references :chat_room, type: :string, limit: 11, null: false, foregin_key: true
      t.references :content_type, type: :string, limit: 11, null: false, foregin_key: true
    end
    add_foreign_key :messages, :users, column: :user_id, primary_key: 'id', on_delete: :cascade, on_update: :cascade
    add_foreign_key :messages, :chat_rooms, column: :chat_room_id, primary_key: 'id', on_delete: :cascade, on_update: :cascade
    add_foreign_key :messages, :content_types, column: :content_type_id, primary_key: 'id', on_delete: :restrict, on_update: :cascade
  end
end
