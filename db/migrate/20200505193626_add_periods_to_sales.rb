class AddPeriodsToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :period, :string
    add_column :sales, :activity_period, :string
    add_column :sales, :territory, :string
  end
end
