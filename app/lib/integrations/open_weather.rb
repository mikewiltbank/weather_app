require 'net/https'
require 'uri'
require 'cgi'
require 'rubygems'
require 'json'

module Integrations
  class OpenWeather

    # include Connection
    attr_accessor :query
    attr_accessor :uri

    def initialize
      @uri         = URI::HTTP.build(host: 'api.openweathermap.org', path: '/data/2.5/weather')
      @connection  = Net::HTTP.new(@uri.host, @uri.port)

      # @connection.use_ssl = false
      # @query = { appid: ENV['OPEN_WEATHER_APP_ID'] }
      @query = { appid: '9de243494c0b295cca9337e1e96b00e2' }
    end

    def by_zipcode(zipcode)
      @query['zip'] = zipcode
      get
    end

    def by_coordinates(lat, lon)
      @query['lat'] = lat
      @query['lon'] = lon
      get
    end

    private

    def call(request)
      request['Content-Type'] = 'application/json'
      request['charset']      = 'UTF-8'

      log_request(request)
      response = @connection.request(request)
      log_response(response)

      connection_api_error(response)

      prepare_response_object(JSON.parse(response.body))
    rescue StandardError => e
      Rails.logger.error "OPEN WEATHER API Error: #{e.message}"
      raise e
    end

    def get
      @uri.query = @query.to_query
      request = Net::HTTP::Get.new(@uri.request_uri)

      call(request)
    end

    def post
      request = Net::HTTP::Post.new(@uri.request_uri)
      call(request)
    end

    def put
      request = Net::HTTP::Put.new(@uri.request_uri)
      call(request)
    end

    def delete
      request = Net::HTTP::Delete.new(@uri.request_uri)
      call(request)
    end

    def log_request(request)
      Rails.logger.info 'OPEN WEATHER API REQUEST:'
      Rails.logger.info "#{request.method} to #{request.path}" if Rails.env == 'development'
    end

    def log_response(response)
      Rails.logger.info 'OPEN WEATHER API RESPONSE:'
      Rails.logger.info "#{response.class.name } #{response.code} #{response.message}"
      Rails.logger.info "#{JSON.pretty_generate(JSON.parse(response.body))}" if Rails.env == 'development'
    end

    def prepare_response_object(response)
      description = response['weather'].first

      weather_data = {
        name:        response['name'],
        zip:         response['zip'],
        kind:        description['main'],
        description: description['description'],
        temp:        response['main']['temp'],
        temp_min:    response['main']['temp_min'],
        temp_max:    response['main']['temp_max'],
        humidity:    response['main']['humidity'],
        wind_speed:  response['wind']['speed'],
        wind_deg:    response['wind']['deg'],
        coord_lon:   response['coord']['lon'],
        coord_lat:   response['coord']['lat'],
        timezone:    response['timezone']
      }

      weather_data.compact
    end

    def connection_api_error(response)
      status_code = response.code.to_i
      return if status_code == 200

      case status_code
        when 400, 404
          error_message = 'Invalid Request'
        when 401
          error_message = 'Authentication Error'
        when 403
          error_message = 'Permission Error'
        when 429
          error_message = 'Rate Limit'
        else
          error_message = ''
      end

      error_data = JSON.parse(response.body)
      response_message = error_data['message'] || error_data['Message']
      error_message << " (#{response_message.to_s})" if response_message.present?

      raise StandardError, error_message
    end

  end

end
