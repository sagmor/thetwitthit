module TheTwittHit
  class Properties
    def initialize()
      @hash = {}
    end
    
    def title
      @hash[:title]
    end
    
    def title=(title)
      @hash[:title] = title
    end
    
    def notes
      @hash[:notes]
    end
    
    def notes=(notes)
      @hash[:notes] = notes
    end
    
    def to_s
      (@hash.map{ |key, val| "#{key}:\"#{val}\"" }).join(', ')
    end
  end
end