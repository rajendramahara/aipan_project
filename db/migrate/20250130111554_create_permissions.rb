class CreatePermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :module_id, null: false
      t.string :module
      t.string :action

      t.timestamps
    end
  end
end
