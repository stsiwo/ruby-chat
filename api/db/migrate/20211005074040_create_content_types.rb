class CreateContentTypes < ActiveRecord::Migration[6.1]
  def change
    create_table(:content_types, id: false) do |t|
      t.string :id, primary_key: true
      t.string :name
      t.timestamps
    end
  end
end
