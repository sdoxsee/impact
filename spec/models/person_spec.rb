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
  end
end
