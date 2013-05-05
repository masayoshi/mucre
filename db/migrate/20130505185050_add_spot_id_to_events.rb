class AddSpotIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :spot_id, :integer
  end
end
