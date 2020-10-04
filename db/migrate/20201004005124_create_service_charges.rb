class CreateServiceCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :service_charges do |t|
      t.references :affiliation, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
