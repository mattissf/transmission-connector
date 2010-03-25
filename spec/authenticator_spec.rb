require File.dirname(__FILE__) + '/spec_helper.rb'
require 'daemons'

describe "connection mechanism" do
  it "should be able to authenticate to a running transmission daemon" do
    start_transmission
  end
  
  def start_transmission
  end
  
  def stop_transmission
  end  
end