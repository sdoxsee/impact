class Person < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :age, :name, :parent_id, :status
  validates_presence_of :age
  validates_presence_of :status
  validates_uniqueness_of :name
  
  def subscribed_descendants
    subscribed = []
    self.descendants.each do |d|
      subscribed << d if d.status == 'subscribed'        
    end
    subscribed
  end
  
  def position
    
  end
end
