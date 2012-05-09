uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
REDIS_OPTIONS = {:redis_connection => REDIS}
HIGHSCORE_LB = Leaderboard.new('highscores', Leaderboard::DEFAULT_OPTIONS, REDIS_OPTIONS)
HIGHSCORE_LB.delete_leaderboard
Person.all.each do |p|
  HIGHSCORE_LB.rank_member(p.id, p.subscribed_descendants.count) 
end