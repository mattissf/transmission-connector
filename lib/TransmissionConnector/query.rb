require 'base64'

module TransmissionConnector
  class Query
    def initialize(connection)
      @connection = connection
    end
    
    def add_torrent(file_path)
      query = {
        'method' => 'torrent-add',
        "arguments" => {
          "metainfo" => Base64.encode64(File.open(file_path, "rb").read)
        }
      }
      
      @connection.post(query)
    end
    
    def get_all_torrents
      result = @connection.post({
      'method'    => 'torrent-get', 
      'arguments' => {
        'fields'  => [
          'name', 
          'torrentFile', 
          'id', 
          'rateDownload',
          'status'
          ]
        }
      })
      
      return {
        'metaData' => {
          'idProperty' => 'id',
          'totalProperty' => 'results',
          'root' => 'rows',
          'fields' => [
            {'name' => 'name'},
            {'name' => 'torrentFile'},
            {'name' => 'id'},
            {'name' => 'rateDownload'},
            {'name' => 'status'}
            ]
          },
          
        'success' => result['result'] === 'success',
        'results' => result['arguments']['torrents'].size,
        'rows'    => result['arguments']['torrents']
      }
    end
  end  
end