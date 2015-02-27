class AddIntroMessageToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :intro_message, :string
  end
end
