begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'transmission-connector'

require File.expand_path('../../lib/transmission-connector/connection', __FILE__)
require File.expand_path('../../lib/transmission-connector/daemon-controller', __FILE__)

def start_transmission
    @config_dir = File.expand_path('../support/config_dir', __FILE__)
    @host       = '127.0.0.1'
    @port       = 13337
    
    @transmission_daemon = TransmissionConnector::DaemonController.new(
      :config_dir => @config_dir, 
      :host       => @host,
      :port       => @port
    )
    
    @transmission_daemon.start_and_wait  
end

def stop_transmission
  @transmission_daemon.stop
  @transmission_daemon.cleanup
end

def get_connection(config = {})
    config[:username] ||= 'test'
    config[:password] ||= 'test'
  
    config = {:username => config[:username], :password => config[:password], :host => @host, :port => @port}

    TransmissionConnector::Connection.new(config)  
end

def get_query
  TransmissionConnector::Query.new(get_connection)
end

def get_torrent_file
  File.expand_path '../support/example.torrent', __FILE__
end