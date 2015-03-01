class AddEmailOptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_option, :string
  end
end
