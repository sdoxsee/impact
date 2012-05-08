uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
redis_options = {:redis_connection => REDIS}
highscore_lb = Leaderboard.new('highscores', Leaderboard::DEFAULT_OPTIONS, redis_options)