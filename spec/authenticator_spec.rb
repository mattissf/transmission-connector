require File.dirname(__FILE__) + '/spec_helper.rb'
require 'daemons'

describe "connection mechanism" do
  it "should be able to authenticate to a running transmission daemon" do
    
  end
  
  def start_transmission
    @transmission = Daemons.call do
      system "transmission-daemon --config-dir /home/mattis/Ruby/workspace-radrails/TorrentHub/spec/transmission/config_dir/ --foreground"      
    end    
    
    
    # wait for "Transmission 1.75 (9117) started"
  end
  
  def stop_transmission
    @transmission.stop
  end  
end