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
    
    def get_list_of_torrents
      answer = @connection.post({
        "method" =>"torrent-get", 
        "arguments" => {
          "fields" => [
            "error",
            "errorString",
            "eta",
            "id",
            "leftUntilDone",
            "name",
            "peersGettingFromUs",
            "peersSendingToUs",
            "rateDownload",
            "rateUpload",
            "sizeWhenDone",
            "status",
            "uploadRatio"
          ]
        }
      })
      
      torrents = Array.new
      
      answer["arguments"]["torrents"].each do |torrent_info| 
        torrents << TransmissionConnector::Torrent.new(torrent_info)
      end
      
      return torrents
    end
  end  
end