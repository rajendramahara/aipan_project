class CreateDepartmentEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :department_employees, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :department, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
