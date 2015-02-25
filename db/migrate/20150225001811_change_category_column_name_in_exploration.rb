class ChangeCategoryColumnNameInExploration < ActiveRecord::Migration
  def change
    rename_column :explorations, :category, :exploration_category
  end
end
