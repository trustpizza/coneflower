class AddPublishedToDevelopments < ActiveRecord::Migration[7.1]
  def change
    add_column :developments, :published, :boolean, default: :false
  end
end
