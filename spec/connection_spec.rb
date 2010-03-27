require File.dirname(__FILE__) + '/spec_helper.rb'

describe TransmissionConnector::Connection, "connection mechanism" do
  before(:all) do
    start_transmission
  end
  
  it "should be able to get a session id" do
    #given
    connection = get_connection
    
    #then
    connection.session_id.length.should eql(48)
  end
  
  it "should be able to authenticate" do
    #given
    connection = get_connection

    #when    
    answer = connection.post({'method' => 'session-get'})
    
    #then
    answer["result"].should eql "success"
  end
  
  it "should notice if authentication fails" do
    lambda {
      connection = get_connection(:username => 'test', :password => 'wrong')
      answer = connection.post({'method' => 'session-get'})
    }.should raise_error
  end
  
  after(:all) do
    stop_transmission
  end
end