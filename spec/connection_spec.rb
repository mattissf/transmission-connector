require File.expand_path('../../lib/TransmissionConnector/connection', __FILE__)
require File.expand_path('../../lib/TransmissionConnector/transmission_daemon_controller', __FILE__)

require File.dirname(__FILE__) + '/spec_helper.rb'

describe TransmissionConnector::Connection, "connection mechanism" do
  before(:all) do
    @host = '127.0.0.1'
    @port = 13337
    
    config_dir = File.expand_path('../support/config_dir', __FILE__)
    
    @transmission_daemon = TransmissionConnector::DaemonController.new(
      :config_dir => config_dir, 
      :host       => @host,
      :port       => @port
    )
    
    @transmission_daemon.start_and_wait
  end
  
  it "should be able to get a session id" do
    #given
    config = {:username => 'test', :password => 'test', :host => @host, :port => @port}

    #when
    connection = TransmissionConnector::Connection.new(config)
    
    #then
    connection.session_id.length.should eql(48)
  end
  
  it "should be able to authenticate" do
    #given
    connection = TransmissionConnector::Connection.new(:username => 'test', :password => 'test', :host => @host, :port => @port)

    #when    
    answer = connection.post({'method' => 'session-get'})
    
    #then
    answer["result"].should eql "success"
  end
  
  it "should notice if authentication fails" do
    lambda {
      connection = TransmissionConnector::Connection.new(:username => 'test', :password => 'wrong', :host => @host, :port => @port)
      answer = connection.post({'method' => 'session-get'})
    }.should raise_error
  end
  
  after(:all) do
    @transmission_daemon.stop
  end
end