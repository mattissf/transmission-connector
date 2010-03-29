require File.dirname(__FILE__) + '/spec_helper.rb'
require File.expand_path('../../lib/transmission-connector/query', __FILE__)
require File.expand_path('../../lib/transmission-connector/torrent', __FILE__)

describe TransmissionConnector::Query do
  before(:each) do
    start_transmission
  end
  
  it "should be able to add torrent from path" do
    #given
    query = get_query
    torrent_path = get_torrent_path
    
    #when
    answer = query.add_torrent_from_path(torrent_path)
    
    #then
    answer["result"].should eql("success")
  end
  
  it "should be able to add torrent from string" do
    #given
    query = get_query
    torrent_file_content = get_torrent_file.read
    
    #when
    answer = query.add_torrent_from_string(torrent_file_content)
    
    #then
    answer["result"].should eql("success")
  end
  
  it "should be able to add torrent from file" do
    #given
    query = get_query
    torrent_file = get_torrent_file
    
    #when
    answer = query.add_torrent_from_file(torrent_file)
    
    #then
    answer["result"].should eql("success")
  end  
  
  it "should be able to get list of torrents" do
    #given
    query = get_query
    torrent_path = get_torrent_path
    query.add_torrent_from_path(torrent_path)
    
    #when
    torrents = query.get_list_of_torrents
    
    #then    
    torrents.first.name.should eql "ubuntu-9.10-desktop-i386.iso"
  end  
  
  after(:each) do
    stop_transmission
  end
end