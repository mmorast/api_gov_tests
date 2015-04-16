require 'minitest/autorun'

require 'net/http'
require 'json'


class AltFuelStationTest < MiniTest::Test

  def setup
    @api_key = "087ZMPdtqzNGRXGPYBwzNZweIlhBAhpt6lSrPKim"
    @base_uri = URI("https://api.data.gov/nrel/alt-fuel-stations/v1")
    @hyatt_station = {id: 62029, street_address: '208 Barton Springs Rd'}

    # Create client
    @http = Net::HTTP.new(@base_uri.host, @base_uri.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE


  end

  def teardown
    # Do nothing
  end

  def test_a_near_station_returned_with_correct_id
    begin
      result_hash =  get_result_hash("#{@base_uri}/nearest.json?api_key=#{@api_key}&location=Austin%2C%20TX&ev_network=ChargePoint%20Network")
      station_id = result_hash['fuel_stations'].map{ |s| s['id'] if s['station_name'] == 'HYATT AUSTIN'}.compact.first

      assert_equal(@hyatt_station[:id], station_id, "The nearest station ID for HYATT AUSTIN station did not return as expected. #{@hyatt_station[:id]} -> #{station_id}")
    rescue Exception => e
      puts "HTTP Request failed (#{e.message})"
    end
  end

  def test_station_select_station_by_id
    begin
      result_hash = get_result_hash("#{@base_uri}/#{@hyatt_station[:id]}.json?api_key=#{@api_key}")['alt_fuel_station']
      station_address = result_hash['street_address']

      assert_equal(@hyatt_station[:street_address], station_address, "The station address for HYATT AUSTIN station did not return as expected. #{@hyatt_station[:street_address]} -> #{station_address}")
    rescue Exception => e
      puts "HTTP Request failed (#{e.message})"
    end
  end

  def get_result_hash(url)
    uri = URI(url)
    res =  @http.get(uri.request_uri)
    JSON.parse(res.body)
  end
end