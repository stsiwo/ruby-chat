class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table(:users, id: false) do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :email
      t.string :password
      t.string :avatar_image_path
      t.timestamps
      t.references :user_type, type: :string, limit: 11, null: false, foregin_key: true
    end
    add_foreign_key :users, :user_types, column: :user_type_id, primary_key: 'id', on_delete: :restrict, on_update: :cascade
  end
end