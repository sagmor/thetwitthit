ProjectName = 'thetwitthit'

require 'rubygems'
require 'rake'
require 'echoe'
require "lib/#{ProjectName}/version"

Echoe.new(ProjectName, TheTwittList::Version) do |p|
  p.description    = "Fetches tasks from twitter and adds them to The Hit List.app"
  p.url            = "http://github.com/SagMor/#{ProjectName}"
  p.author         = "Sebastian Gamboa"
  p.email          = "me@sagmor.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
  p.runtime_dependencies = ['twitter >=0.5.3', 'main >= 2.8.2', 'highline >= 1.4.0']

end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
