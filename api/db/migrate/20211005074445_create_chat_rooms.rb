class CreateChatRooms < ActiveRecord::Migration[6.1]
  def change
    create_table(:chat_rooms, id: false) do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :background_image_path
      t.timestamps
      # this not automatically add foregin key in database, so you need to set "add_foreign_key" additionally.
      t.references :owner, type: :string, limit: 11, null: false, foregin_key: :user_id, class_name: :User
    end
    add_foreign_key :chat_rooms, :users, column: :owner_id, primary_key: 'id', on_delete: :cascade, on_update: :cascade
  end
end