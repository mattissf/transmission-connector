require File.expand_path('../../lib/TransmissionConnector/connection', __FILE__)
require File.expand_path('../../lib/TransmissionConnector/transmission_daemon_controller', __FILE__)

require File.dirname(__FILE__) + '/spec_helper.rb'
require 'daemons'

describe TransmissionConnector::Connection, "connection mechanism" do
  before(:all) do
    config_dir = File.expand_path('../support/config_dir', __FILE__)
    @transmission_daemon = TransmissionConnector::DaemonController.new(
      :config_dir => config_dir, 
      :host       => '127.0.0.1', 
      :port       => 13337
    )
    
    @transmission_daemon.start_and_wait
  end
  
  it "should be able to authenticate to a running transmission daemon" do
  end
  
  after(:all) do
    @transmission_daemon.stop
  end
end