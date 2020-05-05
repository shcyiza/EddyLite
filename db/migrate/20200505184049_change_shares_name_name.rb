class ChangeSharesNameName < ActiveRecord::Migration[6.0]
  def change
    rename_column :sales, :label_revenue, :label_share
    rename_column :sales, :artist_revenu, :artist_share
  end
end
