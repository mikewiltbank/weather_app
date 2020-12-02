require 'rails_helper'

RSpec.describe "weather_locations/index", type: :view do
  before(:each) do
    assign(:weather_locations, [
      WeatherLocation.create!(),
      WeatherLocation.create!()
    ])
  end

  it "renders a list of weather_locations" do
    render
  end
end
