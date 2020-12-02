require 'rails_helper'

RSpec.describe "weather_locations/show", type: :view do
  before(:each) do
    @weather_location = assign(:weather_location, WeatherLocation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
