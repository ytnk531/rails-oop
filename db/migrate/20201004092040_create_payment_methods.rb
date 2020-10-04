class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.references :employee, null: false, foreign_key: true
      t.string :address
      t.string :bank
      t.string :account
      t.string :type

      t.timestamps
    end
  end
end
