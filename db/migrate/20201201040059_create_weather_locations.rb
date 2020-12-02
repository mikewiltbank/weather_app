class CreateWeatherLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :weather_locations do |t|
      t.string  :name, null: false
      t.integer :zip, index: true
      t.string  :kind, length: 25
      t.string  :description
      t.decimal :temp,       precision: 6, scale: 2
      t.decimal :temp_min,   precision: 6, scale: 2
      t.decimal :temp_max,   precision: 6, scale: 2
      t.integer :humidity
      t.decimal :wind_speed, precision: 6, scale: 2
      t.integer :wind_deg
      t.decimal :coord_lon,  precision: 15, scale: 10
      t.decimal :coord_lat,  precision: 15, scale: 10
      t.integer :timezone

      t.timestamps
    end
  end
end
