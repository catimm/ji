class CreateExplorationInvitations < ActiveRecord::Migration
  def change
    create_table :exploration_invitations do |t|
      t.integer :user_id
      t.string :friend_email
      t.string :accept

      t.timestamps
    end
  end
end
