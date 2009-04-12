module TheTwittHit
  class Worker

SCRIPT =<<EOF
tell application "The Hit List"
	tell inbox to make new task with properties {%s}
end tell
EOF

    def initialize
      @config = TheTwittHit::Config.new
    end
    
    def load
      twitts = user_timeline_todos + replies_todos + direct_messages_todos
      twitts.each { |twitt| save(twitt) }
      @config.save
    end
    
    def config
      @config
    end
    
    private
      def twitter
        @twitter ||= Twitter::Base.new(@config.auth)
      end
    
      def user_timeline_todos
        if @config.load_user_timeline_todos
          twitts = twitter.user_timeline(options(:since_id => @config.last_user_timeline))
          @config.last_user_timeline = twitts[0].id unless twitts.empty?

          twitts
        else
          []
        end
      end
      
      def replies_todos
        if @config.load_replies_todos
          twitts = twitter.replies(options(:since_id => @config.last_reply))
          @config.last_reply = twitts[0].id unless twitts.empty?
          
          twitts
        else
          []
        end
      end
      
      def direct_messages_todos
        if @config.load_direct_messages_todos
          twitts = twitter.direct_messages(options(:since_id => @config.last_direct_message))
          @config.last_direct_message = twitts[0].id unless twitts.empty?
          
          twitts
        else
          []
        end
      end
      
      def save(twitt)
        if twitt.text.match(/\#todo/)
          p = Properties.new
          p.title = twitt.text.gsub(/\#todo/, '').gsub(/\#/, '/').gsub(/@/, 'to:')
          p.title << ' /twit'
          p.notes = "Twitt: http://twitter.com/#{twitt.user.screen_name}/status/#{twitt.id}"
          
          `osascript -e '#{SCRIPT % p}'`
          true
        else
          false
        end
      end
      
      def options(hash = {})
        o = { :per_page => 50 }
        o[:since_id] = hash[:since_id] if hash[:since_id]
        
        o
      end
  end
end