class AddColumnsToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :location_name, :string, null: false
    add_column :user_events, :location_id, :integer, null: false
  end
end
