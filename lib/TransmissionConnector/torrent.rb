module TransmissionConnector
  class Torrent
    attr_accessor :id
    attr_accessor :status
    attr_accessor :name
    attr_accessor :rate_upload
    attr_accessor :rate_download
      
    def initialize(torrent_info)
      @id            = torrent_info["id"]
      @name          = torrent_info["name"]
      @status        = torrent_info["status"]
      @rate_upload   = torrent_info["rateUpload"]
      @rate_download = torrent_info["rateDownload"]
    end    
  end
end