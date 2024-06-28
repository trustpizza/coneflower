class RemoveAddressFromDevelopments < ActiveRecord::Migration[7.1]
  def change
    remove_column :developments, :address
  end
end
