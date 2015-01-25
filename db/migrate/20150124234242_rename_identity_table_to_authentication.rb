class RenameIdentityTableToAuthentication < ActiveRecord::Migration
  def change
    rename_table :identities, :authentications
  end
end
