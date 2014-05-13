class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :gists, [:user_id, :created_at]
  end
end
