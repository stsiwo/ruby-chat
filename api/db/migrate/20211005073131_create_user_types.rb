class CreateUserTypes < ActiveRecord::Migration[6.1]
  def change
    create_table(:user_types, id: false) do |t|
      t.string :id, primary_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end