class RenameProvidersToProvider < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :providers, :provider
  end
end
