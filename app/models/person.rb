class Person < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :age, :country, :name, :parent_id, :status
  validates_presence_of :age
  validates_presence_of :country
  validates_presence_of :status
  validates_uniqueness_of :name
  has_many :invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  
  def impact
    subscribed = []
    self.self_and_descendants.each do |d|
      subscribed << d if d.status == 'subscribed'        
    end
    @impact = subscribed
  end
  
  def rank
    send_rank
  end
  
  def countries
    if @impact == nil
      @impact = impact
    end
    unique_country_list(@impact)
  end
  
  private
    
    def send_rank
      HIGHSCORE_LB.rank_for(self.id)      
    end
    
    def unique_country_list(impact)
      country_list = []
      impact.each do |person|
        country_list << person.country
      end
      country_list.uniq
    end
end
