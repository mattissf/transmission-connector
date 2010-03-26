require File.expand_path('../../lib/TransmissionConnector/connection', __FILE__)
require File.expand_path('../../lib/TransmissionConnector/transmission_daemon_controller', __FILE__)

require File.dirname(__FILE__) + '/spec_helper.rb'
require 'daemons'

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
  
  it "should be able to authenticate to a running transmission daemon" do
    #given
    connection = TransmissionConnector::Connection.new('mattis', 'mattis', "http://#{@host}:#{@port}")
    
    #when
    connection.set_session_id
    
    #then
    connection.session_id.should_not be_nil
  end
  
  after(:all) do
    @transmission_daemon.stop
  end
end