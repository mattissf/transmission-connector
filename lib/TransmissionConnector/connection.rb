module TransmissionConnector
  class Connection
    require 'uri'
    require 'httpclient'
    
    attr_reader :session_id
    
    def initialize(username, password, host)
      @rpc_url = "#{host}/transmission/rpc"
      
      @client = HTTPClient.new
      @client.set_auth(URI.parse(host), username, password)
      
      @session_id_header_key = 'X-Transmission-Session-Id'
    end
    
    def set_session_id
        @session_id = @client.post(@rpc_url).header[@session_id_header_key].pop
    end
    
    def post_to_rpc(data)
      JSON::parse(@client.post(@rpc_url, data.to_json, @session_id_header_key => @session_id).content)
    end    
  end
end