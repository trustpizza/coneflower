class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_column :users, :role, :integer, :default => 0

    add_index :users, :username, :unique => true
    #Ex:- add_index("admin_users", "username")
  end
end
