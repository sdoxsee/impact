class Person < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :age, :name, :parent_id
  validates_presence_of :age
  validates_uniqueness_of :name
end
