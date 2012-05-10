class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'Person'
end
