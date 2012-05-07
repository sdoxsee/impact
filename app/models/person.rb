class Person < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :age, :name, :parent_id, :status
  validates_presence_of :age
  validates_presence_of :status
  validates_uniqueness_of :name
end
