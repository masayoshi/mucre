class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :place
      t.string :address
      t.float :latitude
      t.float :longitude
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
