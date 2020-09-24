class CreateRoadTripsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :road_trips_tables do |t|
      t.string :origin
      t.string :destination
      t.integer :travel_time
      t.integer :forecast_temp
      t.string :forecast_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
