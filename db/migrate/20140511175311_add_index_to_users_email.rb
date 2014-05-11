class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  #define email to be unique
   add_index :users, :email, unique: true
  end
end
