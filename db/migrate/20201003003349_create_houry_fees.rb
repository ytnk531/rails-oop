class CreateHouryFees < ActiveRecord::Migration[6.0]
  def change
    create_table :fees do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :hourly_rate
      t.integer :monthly_salary
      t.integer :commission_rate
      t.string :type

      t.timestamps
    end
  end
end
