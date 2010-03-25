require 'daemons'

module TransmissionConnector
  class TransmissionDaemonController
    def initialize(config = "")
      config_dir = File.expand_path('../../../spec/support/config_dir', __FILE__)
      @config_arg = "--config-dir #{config_dir}"
    end
    
    def start
      @transmission_daemon = Daemons.call(:backtrace => true) do
        exec "/usr/bin/transmission-daemon --foreground #{@config_arg}"
      end      
    end
    
    def stop
      @transmission_daemon.stop
    end
    
    def show_status
      @transmission_daemon.show_status
    end
  end
end 