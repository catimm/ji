# LOCAL REDIS SERVER
# Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)

uri = URI.parse(ENV['REDISTOGO_URL'])
REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])