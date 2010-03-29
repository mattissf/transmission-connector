require 'base64'

module TransmissionConnector
  class Query
    def initialize(connection)
      @connection = connection
    end
    
    def add_torrent_from_string(torrent_string)
      query = {
        'method' => 'torrent-add',
        "arguments" => {
          "metainfo" => Base64.encode64(torrent_string)
        }
      }
      
      @connection.post(query)      
    end
    
    def add_torrent_from_path(torrent_path)
      add_torrent_from_string(File.open(torrent_path, "rb").read)
    end
    
    def add_torrent_from_file(torrent_file)
      add_torrent_from_string(torrent_file.read)
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