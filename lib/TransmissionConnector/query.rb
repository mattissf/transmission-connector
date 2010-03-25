module TransmissionConnector
  class Query
    def initialize(connection)
      @connection = connection
    end
    
    def get_active_torrents
      result = @conection.post_to_rpc({
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