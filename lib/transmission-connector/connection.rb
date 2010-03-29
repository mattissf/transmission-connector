require 'json'
require 'uri'
require 'httpclient'

module TransmissionConnector
  class Connection
    attr_reader :session_id
    
    def initialize(config)
      @session_id_header_key = 'X-Transmission-Session-Id'
      
      @rpc_url = "http://#{config[:host]}:#{config[:port]}/transmission/rpc"
      @client  = HTTPClient.new
      
      @client.set_auth(URI.parse(@rpc_url), config[:username], config[:password])
      
      set_session_id
    end
    
    def set_session_id
        @session_id = @client.post(@rpc_url).header[@session_id_header_key].pop
    end
    
    def post(data)
      result = @client.post(@rpc_url, data.to_json, @session_id_header_key => @session_id)
      
      if result.status_code == 200
        return JSON::parse(result.content)
      elsif result.status_code == 401
        raise "Authentication failed"
      else
        raise "Something happened when posting data."
      end      
    end    
  end
end