class CreateAnnouncements < ActiveRecord::Migration[7.2]
  def change
    create_table :announcements, id: :uuid do |t|
      t.string :title
      t.text :content
      t.string :severity
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :recipient_type

      t.timestamps
    end
  end
end
