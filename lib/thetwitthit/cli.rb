require 'rubygems'

gem 'main', '>= 2.8.2'
gem 'highline', '>= 1.4.0'

require 'main'
require 'highline/import'
require 'daemons'

HighLine.track_eof = false
CLI_ROOT = File.expand_path(File.join(File.dirname(__FILE__), 'cli'))

require CLI_ROOT + '/helpers'
include TheTwittHit::CLI::Helpers

Main {
  def run
    puts "thetwitthit [command] --help for usage instructions."
    puts "The available commands are: \n\t install, uninstall, start, stop, restart."
  end
  
  mode 'install' do
    description 'Installs and configure the application'
    def run
      puts "Installing TheTwittHit"
      authorize
      configure
      start_on_login
      
      if agree("do you want to start TheTwittHit?")
        daemon('start')
      end
    end
  end
  
  mode 'uninstall' do
    description 'Uninstalls the application'
    def run
      if agree("Are you shure that you want to remove TheTwittHit?")
        puts "Nooooo!!!, whyyyy, ok, lets do this!"
        daemon('stop')
        
        File.delete(TheTwittHit::CLI::Helpers::PLIST_FILE)
        File.delete(TheTwittHit::Config::CONFIG_FILE)
        File.delete(File.join(TheTwittHit::Config::APP_SUPPORT,'TheTwittHit.output'))
      else
        puts "Uff, that was close..."
      end
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