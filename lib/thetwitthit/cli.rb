require 'rubygems'

gem 'main', '>= 2.8.2'
gem 'highline', '>= 1.4.0'

require 'main'
require 'highline/import'
require 'daemons'

HighLine.track_eof = false
CLI_ROOT = File.expand_path(File.join(File.dirname(__FILE__), 'cli'))


def daemon(mode)
  Daemons.run_proc('TheTwittHit', :dir_mode => :normal,
                                  :log_output => :true,
                                  :dir => TheTwittHit::Config::APP_SUPPORT,
                                  :ARGV => [mode]) do
    
    $running = true
    Signal.trap("TERM") do 
      $running = false
    end
    puts "#{Time.now} - Starting TheTwittHit"
    
    while($running) do
      puts "#{Time.now} - Fetching last Tweets"
      w = TheTwittHit::Worker.new
      w.load
      
      sleep w.config.sleep_time
    end
    
    puts "#{Time.now} - Stoping TheTwittHit"
    
  end
end

Main {
  def run
    puts "thetwitthit [command] --help for usage instructions."
    puts "The available commands are: \n\t install, uninstall, start, stop, restart."
  end
  
  mode 'install' do
    description 'Installs and configure the application'
    def run
      puts "TODO!"
    end
  end
  
  mode 'uninstall' do
    description 'Uninstalls the application'
    def run
      puts "TODO!"
    end
  end
 
  mode 'start' do
    description 'Starts TheTwittHit daemon'
    def run
      daemon('start')
    end
  end
  
  mode 'stop' do
    description 'Stops TheTwittHit daemon'
    def run
      daemon('stop')
    end
  end
  
  mode 'restart' do
    description 'Restarts TheTwittHit daemon'
    def run
      daemon('restart')
    end
  end
  
  
}