class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :saleable, polymorphic: true, null: false
      t.string :transaction_type
      t.float :label_revenue
      t.float :artist_revenu

      t.timestamps
    end
  end
end
