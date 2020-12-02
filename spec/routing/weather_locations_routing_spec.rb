require "rails_helper"

RSpec.describe WeatherLocationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/weather_locations").to route_to("weather_locations#index")
    end

    it "routes to #show" do
      expect(get: "/weather_locations/1").to route_to("weather_locations#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/weather_locations").to route_to("weather_locations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/weather_locations/1").to route_to("weather_locations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/weather_locations/1").to route_to("weather_locations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/weather_locations/1").to route_to("weather_locations#destroy", id: "1")
    end
  end
end
