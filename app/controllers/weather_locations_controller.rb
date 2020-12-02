class WeatherLocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_weather_location, only: [:show, :update, :destroy]
  before_action :set_weather_client, only: [:create]

  # GET /weather_locations
  def index
    @weather_locations = WeatherLocation.all
    @weather_location = WeatherLocation.new
  end

  # GET /weather_locations/1
  def show
  end

  # POST /weather_locations
  def create
    zipcode = weather_search_params[:zip]

    weather_data = @weather_client.by_zipcode(zipcode)
    weather_data[:zip] = zipcode

    @weather_location = WeatherLocation.create!(weather_data)

    respond_to do |format|
      format.html { redirect_to weather_locations_url }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to weather_locations_url, notice: e.message }
    end
  end

  # PATCH/PUT /weather_locations/1
  def update
    @weather_location.updated_weather_info

    respond_to do |format|
      format.html { redirect_to weather_locations_url }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to weather_locations_url, notice: e.message }
    end
  end

  #PATCH/PUT /weather_locations/update_all
  def update_all
    WeatherLocation.all.each do |weather_location|
      weather_location.updated_weather_info
    end

    respond_to do |format|
      format.html { redirect_to weather_locations_url }
      format.json { render :index, status: :updated }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html { redirect_to weather_locations_url, notice: e.message }
    end
  end

  # DELETE /weather_locations/1
  def destroy
    @weather_location.destroy
  end

  private
    def set_weather_client
      @weather_client = Integrations::OpenWeather.new
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_weather_location
      @weather_location = WeatherLocation.find(params[:id])
    rescue StandardError
      respond_to do |format|
        format.html { redirect_to weather_locations_url, notice: 'Could Not Find Weather Location' }
      end
    end

    # Only allow a list of trusted parameters through.
    def weather_search_params
      params.require(:weather_location).permit(:zip)
    end
end
