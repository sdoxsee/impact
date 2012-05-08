require 'spec_helper'

describe Person do
  it "can be instantiated" do
    Person.new.should be_an_instance_of(Person)
  end
  
  describe "descendants" do
    it "should have count 0 for first" do
      person = FactoryGirl.create(:person)
      person.descendants.count.should eql(0)
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
      @lois = FactoryGirl.create(:person, :parent_id => @stephen.id)
      @karen = FactoryGirl.create(:person, :parent_id => @lois.id, :status => 'subscribed')
      @alex = FactoryGirl.create(:person, :parent_id => @karen.id, :status => 'subscribed')
      @harry = FactoryGirl.create(:person, :parent_id => @lois.id)
      @jenn = FactoryGirl.create(:person)
      @joann = FactoryGirl.create(:person, :parent_id => @jenn.id, :status => 'subscribed')
      @jenn.save!
      @stephen.save!
      @lois.save!
      @karen.save!
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
    it "should have 0 subscribed descendants" do
      @stephen.subscribed_descendants.count.should eql(2)
      @jenn.subscribed_descendants.count.should eql(1)
    end
  end
end
