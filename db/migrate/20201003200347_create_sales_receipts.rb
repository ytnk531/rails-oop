class CreateSalesReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :sales_receipts do |t|
      t.date :date
      t.integer :amount
      t.references :fee

      t.timestamps
    end
  end
end
