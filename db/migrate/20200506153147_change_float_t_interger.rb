class ChangeFloatTInterger < ActiveRecord::Migration[6.0]
  def change
    change_column :sales, :label_share, :integer
    change_column :sales, :artist_share, :integer
    change_column :sales, :revenue, :integer
  end
end
