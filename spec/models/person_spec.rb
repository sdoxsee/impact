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
      @lois = FactoryGirl.create(:person)
      @lois.move_to_child_of(@stephen)
      @karen = FactoryGirl.create(:person, :status => 'subscribed')
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
    it "should have 0 subscribed descendants" do
      @stephen.subscribed_descendants.count.should eql(2)
      @jenn.subscribed_descendants.count.should eql(1)
    end
  end
  describe "position" do
    it "should have stephen as first" do
      @stephen.position.should eql(1)
    end
    pending "should have lois as second" do
      
    end
    pending "should have karen as tied for third with jenn" do
      
    end
    pending "should have alex, harry, and joann as tied for fifth" do
      
    end
  end
end
