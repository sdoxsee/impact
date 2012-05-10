class StaticPagesController < ApplicationController
  def home
    @impact = Person.all.sort_by!{|p| HIGHSCORE_LB.rank_for(p.id)}
    @countries = Person.all.sort_by!{|p| COUNTRY_LB.rank_for(p.id)}
  end

  def help
  end
  
  def about
  end
end
