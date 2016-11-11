class CreateEvents < ActiveRecord::Migration
  def change
     create_table :events do |t|
        t.string :usgs_id, null: false

        t.decimal :northing, null: false
        t.decimal :easting, null: false
        t.decimal :depth, null: false
        t.decimal :magnitude, null: false

        t.timestamp :date_time, null: false
        t.timestamps null: false
     end
  end
end
