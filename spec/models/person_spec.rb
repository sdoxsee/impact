require 'spec_helper'

describe Person do
  it "can be instantiated" do
    Person.new.should be_an_instance_of(Person)
  end
  
    before(:each) do
# stephen (s)        jenn ( )
# \                  \
# lois ( )           joann (s)
# \          \
# karen (s)  harry ( )
# \
# alex (s)
      @stephen = FactoryGirl.create(:person, :status => 'subscribed')
      @lois = FactoryGirl.create(:person, :country => 'France')
      @lois.move_to_child_of(@stephen)
      @karen = FactoryGirl.create(:person, :country => 'New Zealand', :status => 'subscribed')
      @karen.move_to_child_of(@lois)
      @alex = FactoryGirl.create(:person, :status => 'subscribed')
      @alex.move_to_child_of(@karen)
      @harry = FactoryGirl.create(:person)
      @harry.move_to_child_of(@lois)
      @jenn = FactoryGirl.create(:person)
      @joann = FactoryGirl.create(:person, :status => 'subscribed')
      @joann.move_to_child_of(@jenn)
      @stephen.reload
  end
  describe "descendants" do
    it "should have count 0 for first" do
      person = FactoryGirl.create(:person)
      person.descendants.count.should eql(0)
    end
    it "should have proper descendants count for a tree" do
      @stephen.descendants.count.should eql(4)
      @lois.descendants.count.should eql(3)
      @karen.descendants.count.should eql(1)
      @alex.descendants.count.should eql(0)
      @harry.descendants.count.should eql(0)
      @jenn.descendants.count.should eql(1)
      @joann.descendants.count.should eql(0)
    end
    it "should have impact" do
      @stephen.impact.count.should eql(3)
      @jenn.impact.count.should eql(1) # her + joann, but only joann subscribed
    end
  end
  
  describe "countries" do
    it "should have count with duplicates removed" do
      @stephen.countries.count.should eql(2) # Canada, NZ, removed France because unsubscribed
    end
  end
  describe "referrals" do
    it "should have count invitations" do
      4.times {@stephen.invitations << Invitation.new}
      @stephen.invitations.count.should eql(4)
    end
  end
#   testing rank is really part of the leaderboard gem
end
