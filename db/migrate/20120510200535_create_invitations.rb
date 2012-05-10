class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.references :person

      t.timestamps
    end
    add_index :invitations, :person_id
  end
end
