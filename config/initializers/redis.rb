uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
HIGHSCORE_LB = Leaderboard.new('highscores', Leaderboard::DEFAULT_OPTIONS, {:redis_connection => REDIS})
REFERRAL_LB = Leaderboard.new('referrals', Leaderboard::DEFAULT_OPTIONS, {:redis_connection => REDIS})
COUNTRY_LB = Leaderboard.new('countries', Leaderboard::DEFAULT_OPTIONS, {:redis_connection => REDIS})
HIGHSCORE_LB.delete_leaderboard
REFERRAL_LB.delete_leaderboard
COUNTRY_LB.delete_leaderboard
Person.all.each do |p|
  descendants = p.impact
  HIGHSCORE_LB.rank_member(p.id, descendants.count) 
  REFERRAL_LB.rank_member(p.id, p.invitations.count) 
  COUNTRY_LB.rank_member(p.id, p.countries.count) 
end
