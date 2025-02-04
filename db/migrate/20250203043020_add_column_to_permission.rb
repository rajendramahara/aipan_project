class AddColumnToPermission < ActiveRecord::Migration[7.2]
  def change
    add_column :permissions, :category, :string
  end
end
