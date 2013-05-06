class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :fee, null: false, default: 0
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :user_id

      t.timestamps
    end

    add_index :events, :start_datetime
    add_index :events, :end_datetime
    add_index :events, :fee
  end
end
