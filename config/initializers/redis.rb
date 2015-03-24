# LOCAL REDIS SERVER
Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)

#uri = URI.parse(ENV['REDIS_PROVIDER'])
#REDIS = Redis.new(:url => ENV['REDIS_PROVIDER'])