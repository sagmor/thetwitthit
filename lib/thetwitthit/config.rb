module TheTwittHit
  class Config
    APP_SUPPORT = File.join(ENV['HOME'], "Library", "Application Support", "The Hit List")
    CONFIG_FILE = File.join(APP_SUPPORT, 'thetwitthit.yml')
    CONSUMER_KEY = 'IvgtcoFEQaVcvckEjoQQ9w'
    CONSUMER_SECRET = 'mS7iOi5QvLqC4oMupeO1kbVXyngyDa5Jq80qVS9KI8Q'
    
    def initialize
      @config = load()
    end
    
    [:access_token, :access_secret, :load_user_timeline_todos, 
    :load_replies_todos, :load_direct_messages_todos, :last_user_timeline,
    :last_reply, :last_direct_message, :sleep_time].each do |key|
    
      define_method key do
        @config[key]
      end
      
      define_method "#{key}=".to_sym do |value|
        @config[key]=value
      end
    end
    
    def save
      File.open(CONFIG_FILE, 'w') do |f|
        YAML::dump(@config, f)
      end
      
      true
    end
    
    def auth(force_auth = true, force_build = false)
      if @auth.nil? || force_build
        @auth = Twitter::OAuth.new(CONSUMER_KEY,CONSUMER_SECRET)
        if @config[:access_token]
          @auth.authorize_from_access(@config[:access_token], @config[:access_secret])
        elsif force_auth
          raise "Not Authorized"
        end
      end
      
      @auth
    end
    
    private
      def load
        if File.exists?(CONFIG_FILE)
          YAML::load_file(CONFIG_FILE)
        else
          {}
        end
      end
  end
end
