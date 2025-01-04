class CreateDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :departments, id: :uuid do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
