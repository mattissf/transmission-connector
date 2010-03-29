require 'base64'

module TransmissionConnector
  class Query
    def initialize(connection)
      @connection = connection
    end
    
    def add_torrent_from_string(torrent_file_content)
      query = {
        'method' => 'torrent-add',
        "arguments" => {
          "metainfo" => Base64.encode64(torrent_file_content)
        }
      }
      
      @connection.post(query)      
    end
    
    def add_torrent(file_path)
      add_torrent_from_string(File.open(file_path, "rb").read)
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