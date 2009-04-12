module TheTwittHit
  module CLI
    module Helpers
LAUNCH_AGENT_PLIST =<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.sagmor.TheTwittHit</string>
	<key>OnDemand</key>
	<false/>
	<key>ProgramArguments</key>
	<array>
		<string>#s</string>
		<string>start</string>
	</array>
</dict>
</plist>
EOF

PLIST_FILE = File.join(ENV['HOME'],'Library','LaunchAgents','com.sagmor.thetwitthit.plist')

      def daemon(mode)
        Daemons.run_proc('TheTwittHit', :dir_mode => :normal,
                                        :log_output => :true,
                                        :dir => TheTwittHit::Config::APP_SUPPORT,
                                        :ARGV => [mode]) do

          Signal.trap("TERM") do 
            puts "#{Time.now} - Stoping TheTwittHit"
            exit(0)
          end
          
          puts "#{Time.now} - Starting TheTwittHit"

          while(true) do
            puts "#{Time.now} - Fetching last Tweets"
            w = TheTwittHit::Worker.new
            w.load

            sleep w.config.sleep_time
          end

          

        end
      end
      
      def configure
        config = TheTwittHit::Config.new
        puts "load \#todo twitts from [yes/no]:"
        config.load_user_timeline_todos = agree(" * your timeline?")
        config.load_replies_todos = agree(" * your replies?")
        config.load_direct_messages_todos = agree(" * your direct messages?")
        puts
        config.sleep_time = 60*ask(
                        "how often dou you want to load your twitts? (in minutes)", 
                        Integer) { |q| q.default = 60 }

        config.save
      end
      
      def start_on_login
        if agree("Do you want to configure TheTwittHit to start on login? [yes/no]")
          File.open(PLIST_FILE,'w') do |f|
            bin = File.join(File.dirname(__FILE__),'..','..','..','bin','thetwitthit')
            f.puts LAUNCH_AGENT_PLIST % bin
          end
        else
          File.delete(PLIST_FILE) if File.exists?(PLIST_FILE)
        end
      end
      
      def authorize
        config = TheTwittHit::Config.new

        if config.access_token
          puts "There is a twitter access configured!"
          clear = agree("do you want to re-authorize TheTwittHit? [yes/no]")
          return unless clear
          
          config.access_token = nil
        end

        while config.access_token.nil? do
          puts "Authenticating with Twitter:"
          begin
            auth = config.auth(false)
            rtoken, rsecret = auth.request_token.token, auth.request_token.secret

            puts "The script will open your browser,"
            puts "authorize the app at twitter and come back here"

            sleep 2
            %x(open #{auth.request_token.authorize_url})

            until agree("are you ready? [yes/no]")
            end

            auth = config.auth(false,true)
            auth.authorize_from_request(rtoken, rsecret)
            twitter = Twitter::Base.new(auth)
            twitter.friends_timeline

            config.access_token  = auth.access_token.token
            config.access_secret = auth.access_token.secret

            config.auth(true,true)

          rescue
            puts "Authorization Failed!"
          end
        end
        
        config.save
      end
    end
  end
end