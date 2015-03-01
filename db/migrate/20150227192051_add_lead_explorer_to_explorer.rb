class AddLeadExplorerToExplorer < ActiveRecord::Migration
  def change
    add_column :explorers, :lead_explorer, :string
  end
end
