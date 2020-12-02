 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/weather_locations", type: :request do
  # WeatherLocation. As you add validations to WeatherLocation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      WeatherLocation.create! valid_attributes
      get weather_locations_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      weather_location = WeatherLocation.create! valid_attributes
      get weather_location_url(weather_location)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_weather_location_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      weather_location = WeatherLocation.create! valid_attributes
      get edit_weather_location_url(weather_location)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new WeatherLocation" do
        expect {
          post weather_locations_url, params: { weather_location: valid_attributes }
        }.to change(WeatherLocation, :count).by(1)
      end

      it "redirects to the created weather_location" do
        post weather_locations_url, params: { weather_location: valid_attributes }
        expect(response).to redirect_to(weather_location_url(WeatherLocation.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new WeatherLocation" do
        expect {
          post weather_locations_url, params: { weather_location: invalid_attributes }
        }.to change(WeatherLocation, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post weather_locations_url, params: { weather_location: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested weather_location" do
        weather_location = WeatherLocation.create! valid_attributes
        patch weather_location_url(weather_location), params: { weather_location: new_attributes }
        weather_location.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the weather_location" do
        weather_location = WeatherLocation.create! valid_attributes
        patch weather_location_url(weather_location), params: { weather_location: new_attributes }
        weather_location.reload
        expect(response).to redirect_to(weather_location_url(weather_location))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        weather_location = WeatherLocation.create! valid_attributes
        patch weather_location_url(weather_location), params: { weather_location: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested weather_location" do
      weather_location = WeatherLocation.create! valid_attributes
      expect {
        delete weather_location_url(weather_location)
      }.to change(WeatherLocation, :count).by(-1)
    end

    it "redirects to the weather_locations list" do
      weather_location = WeatherLocation.create! valid_attributes
      delete weather_location_url(weather_location)
      expect(response).to redirect_to(weather_locations_url)
    end
  end
end
