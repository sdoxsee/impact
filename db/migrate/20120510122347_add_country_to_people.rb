class AddCountryToPeople < ActiveRecord::Migration
  def change
    add_column :people, :country, :string, :null => false, :default => 'Canada'
  end
end
