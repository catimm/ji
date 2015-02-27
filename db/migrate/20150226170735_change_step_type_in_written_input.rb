class ChangeStepTypeInWrittenInput < ActiveRecord::Migration
  def change
    change_column :written_inputs, :step, :string
  end
end
