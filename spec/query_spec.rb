require File.dirname(__FILE__) + '/spec_helper.rb'
require File.expand_path('../../lib/TransmissionConnector/query', __FILE__)
require File.expand_path('../../lib/TransmissionConnector/torrent', __FILE__)

describe TransmissionConnector::Query do
  before(:all) do
    start_transmission
  end
  
  it "should be able to add torrent" do
    #given
    query = get_query
    torrent_file = get_torrent_file
    
    #when
    answer = query.add_torrent(torrent_file)
    
    #then
    answer["result"].should eql("success")
  end
  
  it "should be able to get list of torrents" do
    #given
    query = get_query
    torrent_file = get_torrent_file
    query.add_torrent(torrent_file)
    
    #when
    torrents = query.get_list_of_torrents
    
    #then    
    torrents.first.name.should eql "ubuntu-9.10-desktop-i386.iso"
  end  
  
  after(:all) do
    stop_transmission
  end
end