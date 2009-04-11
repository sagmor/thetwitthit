module TheTwittHit
  class Config
    LOCATION = File.join(ENV['HOME'], '.the_twitt_hit.yml')
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
      File.open(LOCATION, 'w') do |f|
        YAML::dump(@config, f)
      end
      
      true
    end
    
    def auth(force = true)
      if @auth.nil?
        @auth = Twitter::OAuth.new(CONSUMER_KEY,CONSUMER_SECRET)
        if @config[:access_token]
          @auth.authorize_from_access(@config[:access_token], @config[:access_secret])
        elsif force
          raise "Not Authorized"
        end
      end
      
      @auth
    end
    
    private
      def load
        YAML::load_file(LOCATION)
      end
  end
end
