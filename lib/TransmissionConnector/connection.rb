module TransmissionConnector
  class Connection
    require 'uri'
    require 'httpclient'
    
    def initialize(username, password, host)
      @transmission_host = host 
      
      url = URI.parse(@transmission_host)
      
      @client = HTTPClient.new
      @client.set_auth(url, username, password)
    end
    
    def post_to_rpc(data)
      rpc_url = @transmission_host + '/transmission/rpc'
      session_id_header_key = 'X-Transmission-Session-Id'
      
      if @sessionId.nil? then
        @sessionId = @client.post(rpc_url).header[session_id_header_key]
        post_to_rpc(data)
      else
        JSON::parse(@client.post(rpc_url, data.to_json, session_id_header_key => @sessionId).content)
      end
    end    
  end
end