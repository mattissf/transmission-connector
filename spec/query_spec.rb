require File.dirname(__FILE__) + '/spec_helper.rb'
require File.expand_path('../../lib/TransmissionConnector/query', __FILE__)

describe TransmissionConnector::Query do
  before(:all) do
    start_transmission
  end
  
  it "should be able to upload torrent" do
    #given
    query = get_query
    torrent_file = get_torrent_file
    
    #when
    answer = query.add_torrent(torrent_file)
    
    #then
    answer["result"].should eql("success")
  end
  
  after(:all) do
    stop_transmission
  end
end